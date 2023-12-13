Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB981083E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378342AbjLMC3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378272AbjLMC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:29:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834AA0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:29:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc50d7dd3so834592276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702434591; x=1703039391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A+By/dcpP8NgMf5bfJ77th91WWv84vlb2YGj1lcL0s=;
        b=H2Hh05FKZIOeQhNpl6lb+jbEZTI/e027oZDeRo+18Mj/y/l6Rep28Mw9ed865hpKj2
         kHaBva84etf7HcP3yE0tYBhsYdTaCqAOZ164Gjdm/GDIv97UGRHdFtOPatiGmDwPougg
         oeWthKRd50jWE144NouFscWRSagOgnTwNAUiXjyrFfh/IqyWfLNrfnCxdDia1UcVO/AI
         l5dWaI9UvV/wJ2YJc+aPD08xtiHrPNwjgkzOcfnW8p3cD8HA5RxDYIKP1pCc8ouNfgtj
         QcWoYTbrT/KCJkoX0+Bs9Xs5vPiIJ6jc2NalaTSlj9uf0DimrWWOCqcXnJcEjPKXuDcf
         4oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702434591; x=1703039391;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3A+By/dcpP8NgMf5bfJ77th91WWv84vlb2YGj1lcL0s=;
        b=UBDFpH/d+I+Id7aew79rv9YmVASypRcsn+TFA+u83AHGmpFKEUEjhXg1/vgX174jIA
         MoYcE5g+n3tavxIcyGIQnxwDzhURxGmfcKxHpZiw5KxeUtOSGMfAe4rEtsvQtsVRAp/p
         9VzfEyfAZFjNlwzcx7HEAGZYpOPkt5q5QS3IXHTVdDnQCo9LPMNgh7Z+TmmwjZIAP+WQ
         jWG/ZN+OQX6GyMGyEKHCXXsBDUvWr31PSNjgjkzR7M/ROjnm4QJXLWw9XgkYdm4s/jvZ
         BHgNvXyD7meuDsmRuPWUSKvZdPCvW/cXVkkPbxGD8TVmIqHJiddtCTB3SJph4Jyur8KL
         63UQ==
X-Gm-Message-State: AOJu0YxRnsXNZPh6G9jjFEv9wwGZtuUJ/zcAodKQiaTX4hfN6+CEFbDL
        uexy0NqkJb+zWBjnS5uLOxgXJR/cjUw=
X-Google-Smtp-Source: AGHT+IEp0l4xg6brahhIyo7pX86MoJ28L/CSl2SoF4hAHLUajM1JyV1FRmfpaIfhcSkctCDrCXAgiN+ef1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:52f:b0:db5:48c5:302e with SMTP id
 y15-20020a056902052f00b00db548c5302emr56548ybs.4.1702434590930; Tue, 12 Dec
 2023 18:29:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Dec 2023 18:29:48 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213022948.547485-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.12.13 - No topic
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No topic for tomorrow, but I'll be online.

Note, two topics are on the horizon, "Unifying the protected VM APIs" (Isaku) and
"Post-copy support for guest_memfd" (David Matlack), but those are both going to
be pushed out until January due to people's availability (or lack thereof).
