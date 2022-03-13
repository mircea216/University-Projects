package com.company.model.validators;

import com.company.exceptions.ValidationException;

public interface Validator<T> {
    void validate(T entity) throws ValidationException;
}
