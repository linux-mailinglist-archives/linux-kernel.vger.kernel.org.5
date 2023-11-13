Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176447EA242
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjKMRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKMRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:43:34 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9033E171A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:43:30 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b512dd7d5bso3214984b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699897410; x=1700502210; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le091h9+SmT8HEkLKQaXI8mEotPH+FHH8W9gmxh1xkI=;
        b=N5vgReSSZeyfsvzKKRlaDmYO7MNOPFX6CHzTjZ+I5pnGz9IsEWNQTDsJyVwrwbq1y6
         L8MvFZlBDwCUCwAjeBz/auYsuekNJWMAnpPyJikmrRI0UZsH+c0/AcodsYtLZ5qZKSgT
         52wnj4qKgMpl0o38JAkL4Zd608iNFfn6KRCRhy0L68D1EPzm2FcXZSf8O6GE9j8U0gGA
         YOaTg6Eplgo4QCLM8fmFCnQ6rRUY4sJJ0Qa8lxHNqzJh/ESZvMfkucuEQ3qbjzUOCPBy
         4fUnCZySffRess41B88C8k96PPCswwzqCLS7ZoIIudw1B47s9Z/8SxYn97i8108qMNbv
         gLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699897410; x=1700502210;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Le091h9+SmT8HEkLKQaXI8mEotPH+FHH8W9gmxh1xkI=;
        b=sQ2dxgHmlIWFiDWAvB9hbgOF8WS+WQppeDFh4HgSLIaT5XVSAyNLc6nTKwZDaaT0KJ
         5IauABFkPtNT2H4Z6g6dF49cUGce7w6bOrnbKbh3dO06M9Binui79d923H1tgqiqAwCq
         myn/iinaKH1ciVNyrsdYnqf5e/vasStd7PmeaGxvSomtAOx8yCzQXnO58FM3+s54riqW
         ZNhPsoDH+8ghYilAhC+rI4zTP1rYrH+a2Y1sTGfO0Uba/gjp5YZnn8iPrYfWb5JHqT4Y
         ZSk+/OVd93xjRlvut7a7o418+1L6FQZ9K2uoxI7cxt/KXnKnmKgYblIlaS2hHpamBHKX
         0Hcw==
X-Gm-Message-State: AOJu0Ywjyiv1iDvkXeWVQv2lCYbtSz1GUGkrC+laWVWxSUGRxvno5OrF
        ZjcFBIKs56q/6nVLhNQ9NVjzBimlZalsnO2oZjA=
X-Google-Smtp-Source: AGHT+IHlIhjsg0VZj6UMhdqoVbLKZC4ht57dRTvJRDH91CHrY51Z5g3f/a4lNzS5e6dh2NeHQYe6YFdodZ+u05vQYos=
X-Received: by 2002:a05:6870:6c05:b0:1f0:6931:e301 with SMTP id
 na5-20020a0568706c0500b001f06931e301mr10348230oab.0.1699897409934; Mon, 13
 Nov 2023 09:43:29 -0800 (PST)
MIME-Version: 1.0
Sender: aichaadamu883@gmail.com
Received: by 2002:a05:6358:52d2:b0:169:57f3:7563 with HTTP; Mon, 13 Nov 2023
 09:43:29 -0800 (PST)
From:   UBA BANK <info.ubabanksgroup95@gmail.com>
Date:   Mon, 13 Nov 2023 09:43:29 -0800
X-Google-Sender-Auth: 8fKionvvk87SFzAqv7Zr4CyIswg
Message-ID: <CAGb8NjgHd+YbRtre9KnSEOCSCiH389HMLn02HQzdqYNOT1rbBA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,LOTTO_DEPT,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5032]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aichaadamu883[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [info.ubabanksgroup95[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.0 LOTTO_DEPT Claims Department
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
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
