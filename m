Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9EF7FCCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjK2CZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjK2CZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:25:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C10FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:25:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db40b699d0fso7143662276.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701224708; x=1701829508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMJrQUQ0Uq0kC+iIHIog8EZebw/k0pHNIny759MkldI=;
        b=ouiemf5LfSjn5b+7MGweD+NYPLzGk77eJv26YjdrD7l96Sy9gxbLM/+B+jEuos+gzf
         +iqUblwQX/vsC8VfheibhUxUuoaGZHNMBlgoGVFdL5f39puW67uoVIYkIzEI+y/xIBgY
         f3X9EY0w85Oh7NN4fA9FtlRfKyQbXkT1AKCfgtfF2m5UOH0Bhl57akyU+zIAf+OsNnHg
         SDmEFDEeYDf+dc8hDq/m1Kz8gqg0fNcwdyWgaN2DhEMzRJHc/yU+nptN5wvVxE8W6b1M
         hpUtWkG+QSEW92GWtvYUdxIJh/8YPc12WaYjBedkEK8+CFLxHu7pFoyS6/5OPSkwFm8S
         eefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701224708; x=1701829508;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMJrQUQ0Uq0kC+iIHIog8EZebw/k0pHNIny759MkldI=;
        b=EAKYoC/xBPgpQGTgJyPVxs7tcDjNtHu8hvNN0/t6I8n/KYMYchNrPwjCZ5hXdL04WH
         vL+8rNmHDQ3BXWO5YgE0GSbQIWMJ99Bz1wzJTrGFrAeRTuqIU2c1ZWznTd+iwpsOV4h1
         QTVnfRX75ZnAB9bi2uSktQuyJqaWEBBkqn3jyXC9QpBEebWO+FHX4AxMFLlxeJRkJ7x/
         TzmaLMubXsogz6LT8AyzReFoVI69WwAbxIS1xBRwqUbQtRs28618R+HUl3qObRZBnjQj
         AMC6BE1qp3JBGbipCc/JiAzAMMAYL0fJHrKlIjaq+GhZRShkJtoe3t5keIuOjCq9v58q
         dUOg==
X-Gm-Message-State: AOJu0YwNwjWF3dAdAhXrZ5PFqvIZTp6Q9nxP2Yp1CppqP4ieZjh4AlW+
        A6HyXfsWjFDJ0j7rOXAHMYSD+T2JU4Y=
X-Google-Smtp-Source: AGHT+IFq2yJmp1IjHZxPZRJ8E+m6EOd4Uy3iUxIAu7KbjZb8Zp19x9A8Ll6WPlZO47M0kq7WaqcQmhTphFE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:304:0:b0:db4:8e59:c867 with SMTP id
 4-20020a250304000000b00db48e59c867mr369639ybd.3.1701224708554; Tue, 28 Nov
 2023 18:25:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 28 Nov 2023 18:25:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129022505.430107-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.11.29 - CANCELED
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late cancel, there's no topic for tomorrow and I'm still playing
catch-up after effectively being OOO for two weeks.
