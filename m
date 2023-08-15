Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329277D699
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbjHOXUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjHOXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:20:25 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2010E5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:20:19 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c4d7103ef5so1725106fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692141618; x=1692746418;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gnXLzx0iQ/sj9AmoAPnFxr/K+kcyclH54zvX67Dv5kE=;
        b=dgIPeGyE1ILNZfd6fhNhorDJkfkfMZjRyAg2oH6NPZblTVNt8MGQ1olI1uyymMFTPp
         z9yBZCyPaKhODPGbfdxnJ6o7pi9JQHs029nURejNPE9+uXMhGssEKOF+gYt2e4L2UGmV
         nG2K/nti1Pd+cgdukbtRV0v1DIXvsVYDCRRKOcSJqCzbe632um43Qycpe59N+wad3f2g
         7fBSJ5IOxC3CKCKf+0NNYsPGBaiYw+OrWrkYSTu/72EJZRuTtGuKNMufH5VzJh7SL/Om
         0nUNyHN8zXTyf8mHplM++FeSWtDDYQ4FPRdvAn4sewSvXVmAuq+1BQ4dMSWQxAsLDZc8
         lwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692141618; x=1692746418;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnXLzx0iQ/sj9AmoAPnFxr/K+kcyclH54zvX67Dv5kE=;
        b=TyYUHnhIh9rmVC4me9DIfPJpL6pFJRAJWZWZheEh+wCyKSkWQ8hOGMvN0H8Xd7vcrq
         KKmrd3KwbGBk6wl1LXDLCYCSboQ0ocxNXjHkCGC95ZYqPTYDkICLb5qYWRssAHHY2QkJ
         gQ2inQX1NuA5YttZ7wyUTzBjm8/jDrNqJyT26ZcR8j3t622vHWU4rzJpUygmWyWTgoJh
         +1lkK/BRITmwFngH0+oWtmMD/hXHeb5RCQQjooLboUjqcsc/EZzlADlW00hMpMffPpYX
         /Nn6J2LmfstTeIkO6/xNrZamSaSA1XzVnPtEEgDYqE7z91eJEypIIKgmTGCW8ru5+7Ke
         m4Pw==
X-Gm-Message-State: AOJu0Yx5Nz0TrM7UeN8ZVT3CE4H+qugDdkRBryOP0nCeVWR2zbKef+oL
        5rDcuCuP9HPUZw3rZdEctM5TO5oVgLTkYp0raw==
X-Google-Smtp-Source: AGHT+IFU0W48TKDKygi/KY4OUabfsL2PomTI1qKiQbrGnsCnUDpTE5b1SIE7yr/czH/mLoJwdXfQ50vkrUiHRWjZoxo=
X-Received: by 2002:a05:6870:8a12:b0:1b0:24d0:5554 with SMTP id
 p18-20020a0568708a1200b001b024d05554mr2425319oaq.11.1692141618715; Tue, 15
 Aug 2023 16:20:18 -0700 (PDT)
MIME-Version: 1.0
Sender: hannahdavidwilson1245@gmail.com
Received: by 2002:a05:6359:5d1b:b0:135:187f:3f4b with HTTP; Tue, 15 Aug 2023
 16:20:18 -0700 (PDT)
From:   Hannah David <hannahdavid147@gmail.com>
Date:   Tue, 15 Aug 2023 15:20:18 -0800
X-Google-Sender-Auth: 6LWigP_E54r_hPyXEAjcC1mJ56w
Message-ID: <CAK3VGYd=93cM-f+ygRGC0DTyknbfYV_atCy6ovP7UMj3WBuxoQ@mail.gmail.com>
Subject: Peace of the Lord be with you,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.7 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2001:4860:4864:20:0:0:0:2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hannahdavidwilson1245[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hannahdavid147[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings my dear.

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I find mine self. =C2=A0My names
 are Mrs.Wilson Hannah David, a widow and I=E2=80=99m suffering from brain
tumor disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any family members and no
child. =C2=A0My husband died after a brief illness that lasted for few
days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($12.000.000.dollar)
with the Bank. Presently this money is still in bank. And My  Doctor
told me that I don't have much time to live because my illness has
gotten to a very bad stage, Having known my condition I  decided to
entrust over the deposited fund under your custody to take care of the
less-privileged ones therein your country or position,
which i believe that you will utilize this money the way I am going to
instruct herein.
However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible.
It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.
Regards,
Mrs.Wilson Hannah David.
written from Hospital.
