Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F578DFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbjH3TP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbjH3IEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:04:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12458F4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:04:43 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d75a77b69052e-41206fd9717so34554071cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693382682; x=1693987482; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=aKkNAZdYC1OfVdwXudx785oPKLI8x5EHiscSX9ZlJazuXu7Q5JhxpVFaCORxlSB5ak
         uVsKupI5bIdOfGRNkB/bxdGsAqoZ3YwQRiYXaL4y86o/qHH9yn9qPZDzYvEWU3W8IOFA
         Hp2rOmPU4pZb+4RHnW85pWsJ7lGV/+LJQWpjMMINqZXDfSLuOR5rCyLFYYSaZq+eBN5U
         rIcPfDHEt9ZK7vZhi829yPV3shwqTXtk8hgH+a6zb+/bAm17GpOwoER4CHGRrK5p98Sr
         s0DHRaHOjkAxXSDBmuPm8QW/i3Yq8ukn5WINGv/zSwnupreZcztdCD0/QV6WYsUZ/DuT
         JrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693382682; x=1693987482;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=I/UDqIqVoqyTUhHL0UzkZk70jnu+PDogEujdiuhDwOD4D7IVyfvi8PuymqGV4+2a2V
         nr319uHyopN3bX+yZeWTocZlj4Ccc6VplfTP3GsxINKFLCVBt1rmJeSbn9FT97oZxAK+
         PiOIUxEAFa71vbWg3KbnWjGSK2rnPn1EB6Q37ms7d6RoZN/ZWDANlqsrlh+G89L5+9J1
         86pMQYn/gLBiM7fSFpDUPl7dHvYvBDu0m2bki93pVjJu/s+puc94hrcYvBo3czmZonmI
         Hdn3rYSjNWt6Jpyd1ShGLgZSfa9Yb7Q8LkRBwd6v6o3oNzkDTI93athXyQyIsmR+Fpxv
         HpRg==
X-Gm-Message-State: AOJu0Yx3UVlC/O1PjGISqL372z2ej4s4NO1qgCICyOsEtZ7UtHu7+TVi
        tMfLa4hADM9TFxMTUf73xvLO08hhsoT53+cdeGo=
X-Google-Smtp-Source: AGHT+IFzV/CljXJiMvYU5b/Gde5vuMUGi8qOH8TBj+ynDOPOZfbb0I1dEuKYjUEbLiLstXL1GAcYXRHN8MM+isaTBug=
X-Received: by 2002:ac8:59d1:0:b0:403:a338:2aa0 with SMTP id
 f17-20020ac859d1000000b00403a3382aa0mr1874229qtf.45.1693382682060; Wed, 30
 Aug 2023 01:04:42 -0700 (PDT)
MIME-Version: 1.0
Sender: daliamog17@gmail.com
Received: by 2002:a05:622a:1354:b0:405:5648:1b66 with HTTP; Wed, 30 Aug 2023
 01:04:41 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Wed, 30 Aug 2023 10:04:41 +0200
X-Google-Sender-Auth: dbGE1qNzTSmmAd6bad9gWTunpp4
Message-ID: <CAB1EUCdQ77U9td01hK1y7hdOaFQFJ-yXN645ESuLZcs-APY+8w@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_8,MONEY_NOHTML,RCVD_IN_DNSWL_BLOCKED,RISK_FREE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:844 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [daliamog17[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [daliamog17[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.2 HK_SCAM No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_NOHTML Lots of money in plain text
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dear friend,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs. Lenny Tatiana aging widow
of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (19.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

best Regards,
Mrs. Lenny Tatiana
