Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6177FC28A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjK1Rjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344940AbjK1Rju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:39:50 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB90FDC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:39:56 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1fa2b8f7f27so1924505fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701193196; x=1701797996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le091h9+SmT8HEkLKQaXI8mEotPH+FHH8W9gmxh1xkI=;
        b=bUuoH/u2PBhJ6m9V3pRAhsJ6VvjYGrjmdsj0FF9yjavwrZ05ODCxwRqy/+kVzyq8xT
         klEcwIyjy2rn6niULdz7fcCnE052NfvZrA293ZLseL2GqfMCz/JoCwnmCZnhT6xLEDDL
         kpdINDA46Dz4yJVSj59KL4pPXyQBydkKYAKBzxewHPB0Qb3idpwXXHCAVF/8vxXfCIb2
         vmno/AUpU2AR7/D6/fcl2+osERsRNc2VpI3/wXe0G1RuHXDUdnfobPZrabXOGvjHE9nQ
         cq2bu5C9KLz5sJuge6pur5YmDvbQlOJ+W7E3s1qoNVm8qt5n+InB7n2A5cepN5ZkKwQ4
         aeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701193196; x=1701797996;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Le091h9+SmT8HEkLKQaXI8mEotPH+FHH8W9gmxh1xkI=;
        b=E7Wi9wSYkB+ma6LU5f1fu6u1V93DOXruxZ6XyRlWmnE2SmJ3uzahWt8WwjHOnxKwPB
         KpeqbAeS58Zi5OHe9sGNHJ7fOHgdsSm+ZooZq5/7J65epSEhMmaPbqQhPbRVNpDS5C+w
         phj/6CH7xWpA0N/KxJTHC9EEXVAtG+MAEzlJe0DHuGJyTz4XjYQpMPVoAC/odauJAKEm
         Hj2g+OHaMEEj7ogu5UD66tzJKRQ2swhKQhLWiA7NHsrW3Maf+gbGRqN56QPlA2A2fBrS
         TUzCXqJ/5eYkHZKYf6iU0wY/4bcmiR0bTrWrZosESR9wKKSJfXKDef1wY65spUtp6LDW
         hACA==
X-Gm-Message-State: AOJu0Yw+XNQzGg+g3lcbXE8xjLioweDRFqhk6NhoWdNviHKimTBHl+IM
        hQ131mxgmZy2xS/tvQdD/VhVX8XUy8JSbQCEYIY=
X-Google-Smtp-Source: AGHT+IFMFFRK6pSQpgFsrwwSowDoPFSES9MGuZ+CGck1p9Uxu7ZlOEz2+dYtWr0qT+zHBHsIQCzoMc9d76JFvae08NY=
X-Received: by 2002:a05:6870:75c9:b0:1e9:da6f:a161 with SMTP id
 de9-20020a05687075c900b001e9da6fa161mr22627360oab.3.1701193196133; Tue, 28
 Nov 2023 09:39:56 -0800 (PST)
MIME-Version: 1.0
Sender: aichaadamu883@gmail.com
Received: by 2002:a05:6359:2f8b:b0:16e:3a3:262b with HTTP; Tue, 28 Nov 2023
 09:39:55 -0800 (PST)
From:   UBA BANK <info.ubabanksgroup95@gmail.com>
Date:   Tue, 28 Nov 2023 09:39:55 -0800
X-Google-Sender-Auth: 3KDoSkvrVEy1qPcuZ92VWKeIUMI
Message-ID: <CAGb8Njgd43brZ85BBgkDwkfY0fBoguHOBvxXdSoVq5+Z=NzFUg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,MONEY_NOHTML,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2001:4860:4864:20:0:0:0:29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aichaadamu883[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aichaadamu883[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.6 MONEY_NOHTML Lots of money in plain text
        *  2.0 LOTTO_DEPT Claims Department
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GOOD DAY.
YOU HAVE BEEN REWARDED WITH THE SUM OF ($2,500.000.00 USD) GRANT FROM
THE IMF EMPOWERMENT FUNDS.

CONTACT US FOR MORE DETAILS ABOUT YOUR PAYMENT.

BEST REGARDS
KRISTALINA GEORGIEVA
(info.ubabanksgroup95@gmail.com)
PAYMENT DEPARTMENT UTB
