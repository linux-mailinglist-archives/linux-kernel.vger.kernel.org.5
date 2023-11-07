Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D317E361C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjKGHxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:53:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F4FD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:53:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d865854ef96so5482180276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699343607; x=1699948407; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tacCKVeS0tJPQ+TxVMZRPW7qVwER/HLqbPZfwniYTbo=;
        b=JLiPjYManbUAsHa64c+bJ4XI0GXCXaYpNFsOlApYDTszx0hVfY3rEU3HmnLVvO5Ft5
         WBLYAng92n8RzxR5IA9iIifkP2GL6uV2L+eJTc/WXl6kEybaFgdYNO3T8hE2TLRnygLg
         igRxgz96HwgAmqtNfsAF3ziKCnnyZsmPe+YQpoiI8V8XNGkMVFjOmxScchIDSXB5BmWA
         H2aSZ4VH9RJDXGzDgnFTEbIdg7Sq4L9PE3z/g+p23YXtbQ/mNAx0EsikRlMJwAATFVB7
         qIby7DquqDZ8FYOBJn3AhwrI2T7301wS8tLLEzVkRQeZQ6WWl85vSpHWBjJugUZtHhES
         Thwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699343607; x=1699948407;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tacCKVeS0tJPQ+TxVMZRPW7qVwER/HLqbPZfwniYTbo=;
        b=SXsqTyi/qPt4H8QQwISiFyZhCYC2g9Wn/0aiK6mXmKSAQnbUHdW0X3bV8dOdefkFaB
         5ifLS9+1DQc+YNhCFH/KntpOjZT2KTZxGSjGUwM1OqbPW/McAB/mTvn4+qyMz9BB3QIM
         V88s79fv71gmjX6NTSYKcPKmRZl0fyOroFLpcFKViaZp4LlJZDejW1tMHOCF7mWCuoY9
         tE+BiEvC+z90DuZUb5Qa+gxX5YBwWuCqTuUQT+C5S3P03w2/O/V5qKD4NL0KLCeYe0pk
         L+s+fwGPIbc74uH84/adQsLPt14XdeBLTpr9TZCPuwqmJfeRyM6hBQJ+9XqbYroOQSZq
         LT4A==
X-Gm-Message-State: AOJu0YyM1MSMCGjerwZC44x7mkO2DjaBYqsRrQcT9Xwju2d3X0u1i7Jb
        M7boyT/Vu16s8oJtpsnEbBxXnBKXLY2KcxtV2sM=
X-Google-Smtp-Source: AGHT+IHbhkWHt5EoGDLQbGGAOrvGcziDHYE3FCZ55XyBJsMTFk7JOEBY4eSOuJmjHboNLSJbCnFgqOfmR2BYhHYB2Uo=
X-Received: by 2002:a25:73cd:0:b0:d91:1296:947 with SMTP id
 o196-20020a2573cd000000b00d9112960947mr28291034ybc.40.1699343606945; Mon, 06
 Nov 2023 23:53:26 -0800 (PST)
MIME-Version: 1.0
Sender: gaisha851@gmail.com
Received: by 2002:a05:7000:d387:b0:4d4:2efa:ffbf with HTTP; Mon, 6 Nov 2023
 23:53:26 -0800 (PST)
From:   "Dr. Thomsom Jack" <jackthomsom7@gmail.com>
Date:   Tue, 7 Nov 2023 08:53:26 +0100
X-Google-Sender-Auth: cQur0yMZF2DCWDA7NfVh8Vh97DI
Message-ID: <CAH3QzgV3pD3XtD-T_rOkOk_s0P+jhDjoDtphrFqeyeLRyyLV=w@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:b2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gaisha851[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gaisha851[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a good news for you.Please contact me for more details. Sorry
if
you received this letter in your spam, Due to recent connection error
here in my country.a

Looking forward for your immediate response to me through my private

e-mail id: (jackthomsom7@gmail.com)


Best Regards,

Regards,
Dr. Thomsom Jack.
My Telephone number
+226-67 -44 - 42- 36
