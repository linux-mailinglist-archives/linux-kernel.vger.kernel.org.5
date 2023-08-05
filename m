Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD1B770D4E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHEC23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 22:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHEC21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 22:28:27 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414094EDB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 19:28:25 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-584034c706dso28927847b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691202504; x=1691807304;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xaHyFd/11/GlgUBkCwfx+jW6fBw1OjzEYwRR90O3NUk=;
        b=GWtqQRd1RJs3GHO/LrkvbY+2UTRTgHrNRbVUSL+QUBAn5lsOei9A0iFvWacc5bHNlu
         y21x6X3lDkMjZBYeszmsKKddc9rYyzVsqP8hWA87nEVavdQhrcUBRK72vJZiFwMZzrQa
         DRjBm2JrkxeD6U+OCFIZEmy5/S5czvLVfilBFfoo7vFZ0X2v9Z4mJLfzRMB5cY5JA1lK
         EVG0tDHEVPAdu5kpOVEwDwO2Qf6lP5BTqkbSvDoPw/NnewiqFL4mmY1Z3g5053RdR7ii
         38nRUHJzzJi2bJzPMH/gzTykZxzY/z1sSAxEPGGaBse6xrkVp/bnL56vynB5BU2rqy40
         prVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691202504; x=1691807304;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaHyFd/11/GlgUBkCwfx+jW6fBw1OjzEYwRR90O3NUk=;
        b=B7iT+C/IumWWJ+YHXe6Qa5K4nYe18ca0sXRhudR1mie6pqSq79mcjBqCGsnAT23uus
         e2ho7xVxBvSxX+2K99vDEosPGM4Q+Vp/GKkBvaAF2i7U1/0pwa9lidpxJ9g8RyAB7gxB
         o2rvtfywd8fktyFm9cyFjbm3x2C6tXPtG5dRlw4w3mk87SirHjQ0kGopIcB0fVISmQhf
         4Lir/ajo6ZTW7ROJaOoRhmhciZBIG6wWBjlfUiAPDo+x2nxwgNL/nD6TKEXnaj7FIJU0
         HYALx7BrJyuNwyWCGxHMT172mciInCGRTUtlP38efWtoZKiEFU8BQcblI2wZJULBIn3A
         l9lQ==
X-Gm-Message-State: AOJu0Yzzq5MSlLCFxNkPR2wcTlvJjWOkDM8G+nWUl5sH/mA8dKuXq9XQ
        Zkk0Twc0Pik7B+yzw8ihet8BL4OJhOlH9BXMObU=
X-Google-Smtp-Source: AGHT+IEFaXBaPoNBp7lW7sAFyB2Ld+3onP+J7SFZfQ3tkUeOqw/PO9tYtCzmBPf/rdepmCkkAX0OPCg77i7kwTtEjT4=
X-Received: by 2002:a0d:d608:0:b0:586:9fd4:6a9f with SMTP id
 y8-20020a0dd608000000b005869fd46a9fmr3499870ywd.46.1691202504172; Fri, 04 Aug
 2023 19:28:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:60cb:b0:326:40e:4f0d with HTTP; Fri, 4 Aug 2023
 19:28:23 -0700 (PDT)
From:   "Mr.Ghazi Ahmed" <mrghaziahmed502@gmail.com>
Date:   Fri, 4 Aug 2023 19:28:23 -0700
Message-ID: <CAB_wAu-XGN43qr-sWMEDsBNLuEeyZmBfKWpD=XaDZLV5=vRd1Q@mail.gmail.com>
Subject: YOUR URGENT RESPONSE IS NEEDED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MONEY_FORM_SHORT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:112f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5553]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrghaziahmed502[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrghaziahmed502[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.5 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
I have a business proposal in the tune of $10.2m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information's if you are interested
in this tranasction for more details(Mr.GhaziAhmed@email.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
Mr.Ghazi Ahmed
