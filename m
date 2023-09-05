Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8575479273A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbjIEQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353928AbjIEIjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:39:08 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB093CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:39:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so3077805a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693903143; x=1694507943; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hyTIowAic/QcOcDxtwV9f9KcXdjYO2MpLikA3ZRxr2g=;
        b=LYjRE278YjytkP+Om5BIOaf1blc42O9Uo/Izn/n949OTFeChn5Xk1BKi309MRbJaUi
         wcAux8j7tr+2INc5Odd9jATKqh7Dyhs0LufkcSL2Vi0L4tHkvbg5XfnLN2YaeSgWIlcY
         o+L1Nd3LtJMhamkOLKMDNZH7o11GYBwRTunubG+WY8mVpsQEltbVaHI5tzMFlWVeNpba
         ZXa4JJR9ygPovzlQSFGN433EdQ1Za25jlhdWkusWbM2mihEMLLAyCDIC+tzP/WRaR/eF
         KUFQYQhlIfeZE16WiSsoZIigGFFEPKVOWEFvkPhpmzTjved7iNCQQM6Skq3t41WbH4Kp
         aajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903143; x=1694507943;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyTIowAic/QcOcDxtwV9f9KcXdjYO2MpLikA3ZRxr2g=;
        b=DwPFcFaxWKpjoPwl+apeFvJtYJBaUSw7zlAMx2Am6SGKg5nAG7tBU/IJmozVSQjE48
         FAeh35eRqXKy3cdr+AFHeQ/V7UrznAWmCDRf7y9GMygZTTQLBGYtko4yHOY8Rrm/eHhP
         o6qSNhQlboa17qjPRlTgukvl2ZiSU5+B9sH0c851ZGlCACGME4PEpHsf+PyWNDiOCxYM
         of0eQXQXlAHBXTp+CD9NCko7G8YvRoDTWkmYpsso6ve3HFFK8Wmrstxho9LdT6QacHrR
         hZ+AKYY4FmKKcBgJqI9y8DtVm/VH6NZCiaukzdqtLHx5ihoXw+rAvjVGXnYM45/4ChEh
         m36w==
X-Gm-Message-State: AOJu0Yw8B8RLHsyxT4aimY+/6OfE95aTMwNutES+Dpa+W8GvOU7K9d+z
        WVlOnH5RhdF/V7N+D4Ee/o9OH9d13r5CC17nJI8=
X-Google-Smtp-Source: AGHT+IGvboT0n0FCdxIyLWG3+sgCRVSpETjl94gJDApfq2U6U/ZxByemehUhnYNg885l3xVpViaFPtwkgNT5/10xASw=
X-Received: by 2002:a05:6402:5170:b0:522:ab06:7213 with SMTP id
 d16-20020a056402517000b00522ab067213mr7900175ede.27.1693903143129; Tue, 05
 Sep 2023 01:39:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2785:0:b0:228:8da6:e795 with HTTP; Tue, 5 Sep 2023
 01:39:02 -0700 (PDT)
From:   john mike <johnson707mike@gmail.com>
Date:   Tue, 5 Sep 2023 01:39:02 -0700
Message-ID: <CALQr8iMj2dHEer=5hvE4H3S88Ot_jiWC46nAUhpttqa36kX6MA@mail.gmail.com>
Subject: waiting transfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valued Attention
Our recent record   indicates that you are eligible to receive an
optional repayment of cash fund!! $1.2m which has been found in
the security vault registered in your favor under your email account
waiting to be dispatch without claims.
the account is set up under your email address  can only be obtained
by you (receiver),all  you have to do is to provide
Your full Name.....................
Direct Telephone: ..............
And delivery address........... For immediate shipment
Thanks and anticipating your urgent respond
Levy ,DHL delivery charges and other costs which amount total 630 Euro
Yours faithfully,
Johnson Mike
Section assistance and   Verification committee
USAfro-Euro   Debit Reconciliation Office
