Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A1F7CF161
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjJSHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjJSHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:35:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B3112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:35:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-5a1d89ff4b9so4589519a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697700945; x=1698305745; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRnjGS3KZVpBTmWigSdwjX0vYClCmLeUmDVDKE/rAWM=;
        b=eRjhMy8J0Prea6AraNmQc+wMvwniADdzuerlvXTgIyAYM1lOeKtagFxdX9nSIlknka
         pbbxAUh3M9RvVkPIdOQ9liTefmX4QhrFxMr5CrBwatwOTd03apDEe5fskpgs2ATpGsKo
         POUvzZAZieu90Dk2aALshHJ9VYFriPvEaztumvzZzAbIQ9NFbXgl2xrqkS5C+4UH6C8A
         MN3RinGE297zxlDcco4Z7TekiM4lQO8q7cVv7HYgvsyHx5guHigljlxtSZ2z1E1rdH9A
         0TziAfKJUrvgep2UJsfW2YibJeer9uCtMHNe/Datf2T6iQANWILsNwC7TMftlHKz1RgR
         VvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700945; x=1698305745;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRnjGS3KZVpBTmWigSdwjX0vYClCmLeUmDVDKE/rAWM=;
        b=Gm2sal6jWHsjC1/LyRSU5xgplVMB4c5aPtcqgTBhCTq8ZsbFM68zFiJt/BYQVsmilT
         s2O6hJWzrna+m+d+Uh5Q9i/7xDf0MVmb80xuNlIn5PqE+YtprTvjETeNbZWaD8qLrWKS
         /fa9tZQf23QTG/LL7ZjsbB6ACzz8m45oC3FEEvQ0ak9SWEx8Djx6HEzs9TG42OVpstiU
         bk82F7UMXcM8c0FQzxY9QijQurbSHc7DwvR0RDcDPeV7aVDo7vd853N7m4QPLLIPR8Mw
         E++jhnx48OJANFyRs7aM/C4GiNu9KvoJdGOrj2MEBOiOFU2WG56opjAyT5a0NCZuESN0
         NJFw==
X-Gm-Message-State: AOJu0YyfuP2t+UmP1tlWPr7kh3YofMm9IZ9ptiDUFvIXQ2OZu1qncEcn
        2l8QLjPwbDV8dCMp6ngvZVRC3JJV6oRD4TswbUc=
X-Google-Smtp-Source: AGHT+IECIxTytTxMb/LtUGElOJKe2/N5aprzKfu3ROghaO1xcVAx4tQtzwCUjUJSJ0TtG3dJprL/RKWMKZfwWsI0Fpk=
X-Received: by 2002:a05:6a20:ae1a:b0:15a:290:d83d with SMTP id
 dp26-20020a056a20ae1a00b0015a0290d83dmr1066463pzb.41.1697700945503; Thu, 19
 Oct 2023 00:35:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8e8f:b0:4e4:5b97:a2f0 with HTTP; Thu, 19 Oct 2023
 00:35:45 -0700 (PDT)
Reply-To: ch4781.r@proton.me
From:   Mrs madina <bl533179@gmail.com>
Date:   Thu, 19 Oct 2023 09:35:45 +0200
Message-ID: <CAG0OURYRXtDi0dpQwtQEXF3DJvCuQJq1TbiWdqtBfwQNoq4moA@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bl533179[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bl533179[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.4 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a personal Project in which i need your assistance I would like
to be sure of your willingness, trustworthiness and commitment to
execute this transaction with me. I seek your partnership in
transferring  this fund {$US6,000,000}. If interested
(mrs.madina2541@gmx.com ) for more details about the fund. For easy
communication send me your whatsapp number .

thank you.

Mrs madina
