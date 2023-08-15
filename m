Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B053B77CBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbjHOLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjHOLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:21:45 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474A19BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:21:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-589c7801d1cso40855127b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692098490; x=1692703290;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fk0Z7pD83yFNEU0SpU5U6IQN4fDKlSlXyD3GmZcQDTI=;
        b=nXuzdgs7U7coOtaFZh/GqKuZ012gXvvswOP7xVXLuD9Qdwh/EXRFMOoATG8p09Gv0K
         FpBz2i/6pqhBfyZPCCj352n2DU+U9oz5bvazhB/i+lAjZp5uNyJm+EfmNRwvv8Xkw1/U
         pWYndDssxF1c+2z3Tz2EKExbt7buhob3NTWZjeCDHnH8BThJ01fEeSWqC9kKQ69KOxWE
         lhU7g9Eg22B1NfE/SC+Nr2iScIKtz2oVVFLIDHT3a5DhbjkTXw3DNuHiYqQM9aAQE1Jn
         CH5wykuGVLPFo95hsxvxjCBaEJnK+7h417ZnLNg1op28hvaVB5UzfrLXEsAU3ohtN2Tr
         Lytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692098490; x=1692703290;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk0Z7pD83yFNEU0SpU5U6IQN4fDKlSlXyD3GmZcQDTI=;
        b=Dc65KKjY966Ki8aIl0ph5PK+nytNTpXoQC1BS1JItytd8p22DtHljzIkWK1BE0ik7k
         u5dQOohpuJrBIzTVRpZnH0ETPmJQhaZprKDf+rJCY5YT1tIWyR3jedIdp7frCMvMorAZ
         9aZ+i1DWhX9pig1r2+XqSJVT5EwvwCmPACUy6Nbanl7FeY/0/ko5wLhiLf1lXMG9SLN3
         mCZAGrLh0RwHXDBdu/fAu8px2rzFrCiqXjJe9k4TxqOOZ3eZtumGgt8utmm4de+Texwn
         JJo5xV/IWeE4Jk3CPa+4dZ+neJx/BOXrj91xGdSqxBWCKno84T8NfhiZ99zIncUz4QLj
         XOrg==
X-Gm-Message-State: AOJu0Yz28nyGqNYij4FWq5n2j5s2Xc/L5YvmdxfwABNSXGnSKdBYJfNp
        iMsP0OGxmKnJdouRB+NmvsjXBybdsruNsX7sX5U=
X-Google-Smtp-Source: AGHT+IHT4P7x/UUadxePBKfq5GI7j457/Jd/0K/ha/v6SCWgwZtav4iMol6B2IsLTGEQtq/p/f4Gftm0vG2sewqZ50k=
X-Received: by 2002:a0d:e255:0:b0:576:93f1:d120 with SMTP id
 l82-20020a0de255000000b0057693f1d120mr13863626ywe.12.1692098489956; Tue, 15
 Aug 2023 04:21:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:37d4:b0:319:f25e:7bf with HTTP; Tue, 15 Aug 2023
 04:21:29 -0700 (PDT)
Reply-To: borismayor1967@gmail.com
From:   Boris Ayiete Esq <infogfmfsa@gmail.com>
Date:   Tue, 15 Aug 2023 11:21:29 +0000
Message-ID: <CAEWLT8MTPkXh+wVm7JeB7_VwHDzW8+KSEJ306Yez8Lizt=XfYg@mail.gmail.com>
Subject: From Boris Ayiete Esq
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:1134 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [borismayor1967[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [infogfmfsa[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am from Republic of Togo.
There is this business transaction of fund left by your late relation,
Who died in Turkey this year earthquake.
Lets put claims on the fund before the security company close the
account as unknown box.
Kindly reply very urgently .
Mr Boris Ayiete
