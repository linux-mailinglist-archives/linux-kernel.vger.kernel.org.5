Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE8D799FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjIJUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIJUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:24:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF09135
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 13:24:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58d40c2debeso38067857b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694377470; x=1694982270; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPK2akfGkxfliBdm1B1rykv3Q3W/tZl7VK0ifr4uOX0=;
        b=UkaWWwyEKhw2lU/GkvhdnyMUh/A1yHm4+MP72I5ipIFuTt1KIPl1aIr+vU7w+LY6+W
         crrDEXrdhGyVkT2HCQXJZuF+/btIgU/0wjf7lkrZ5kCbD3BJ+IcQzfSq3Ax8PFxToAA4
         fm7rr/V7l1V/ZYUnDzbR/WtQ3b5g3PRU6wv2nZtmMcTtcIIbcyn63zqwfmcEIza22Zr/
         sltlVK63Hz7uhr50Sx7VknnipOT2fuyj+utpt7Bk7ZG2iOo06aaBV065EeoXRmqzg6xQ
         5d1St4KaLlUNd6LIP8BQAOCX4mgzyQppaGbebWg471Yh5MZ3fzbcZklinEruWY6HNR0x
         KQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694377470; x=1694982270;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPK2akfGkxfliBdm1B1rykv3Q3W/tZl7VK0ifr4uOX0=;
        b=uQ4zJYfe+xfruZh9tLsPsaXt2vd74+pqbdto1EYxmKGCuuVCJytbkR8+TrIc6Pul8l
         I11WKuI2hvvBxlTo9gci/ul5/avLIRzIPyFmnhRDm01vVH9B/8xTTbC75P7GteSuwX9u
         iTZVE0u7sVl1rIzlj/mTBWOfNfCI8cGc4MvVaUr9Bn+DV/X1JW5VFMs1vVk6tM3Tp+Kf
         Gp9C2LgrBr5t/Y5oNMJqprLY41fOOgXrIPwXfqYNEzA4NEbZ/MMqLZD8M5veQRe6VhCZ
         m0ldGjiQS/ctzLNsWJ+Cmu6HY990xc4mtYpHiX7wBaVZSGjuO5iNDyG1Y5B2P3OJsOer
         8E5A==
X-Gm-Message-State: AOJu0YzUp/QoQo3O7fkAIuufIHBE/MXjOQ85R68XVArdDGK6prdXEFi8
        HoOuWIdYiStm8anIy3QAbwd5BiCByz2fAooCPmc=
X-Google-Smtp-Source: AGHT+IE81gMO4gvRJN5KEXCY5/3nBLTG0HQMD0vzmkTfDDX9ibLT6M4XZ5vRJE38FN3eGPl1u+ye0gvYesRAwyZd6nQ=
X-Received: by 2002:a0d:cbd7:0:b0:57a:50ba:b3a0 with SMTP id
 n206-20020a0dcbd7000000b0057a50bab3a0mr8313601ywd.12.1694377469693; Sun, 10
 Sep 2023 13:24:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7654:b0:339:167d:ffbc with HTTP; Sun, 10 Sep 2023
 13:24:29 -0700 (PDT)
From:   Ududonka Ahmed <ududonka.ahmed1@gmail.com>
Date:   Sun, 10 Sep 2023 20:24:29 +0000
Message-ID: <CABdpV841fgyGAFs-9LL0DMESJBsmO2JVVn_yvqO-O3U_uv1Gig@mail.gmail.com>
Subject: Thanks you very much
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DEAR_NOBODY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        HK_SCAM,LOTS_OF_MONEY,MONEY_ATM_CARD,MONEY_FRAUD_3,MONEY_NOHTML,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ududonka.ahmed1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ududonka.ahmed1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 DEAR_NOBODY RAW: Message contains Dear but with no name
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.7 HK_SCAM No description available.
        *  0.0 MONEY_NOHTML Lots of money in plain text
        *  0.0 MONEY_ATM_CARD Lots of money on an ATM card
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_3 Lots of money and several fraud phrases
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,

I was shocked you stopped communicating me, I really can't understand
your reason for doing so, but I am very happy now to inform you about
my success in getting the fund out of the bank with the help of a
staff working in the remittance office and also with the special
assistance of a French business woman that catered for other
logistics.

However, I left the sum of $800,000 (Eight Hundred Thousand U.S
Dollars Only) in an ATM cash withdrawal Card. This $800,000 is for you
and it is purposely for your compensation for your little effort in
this transaction. The ATM Card is a global payment card which is
acceptable, workable and usable worldwide in making daily withdrawal
of money from any ATM location.  So you can be able to make
withdrawals of money in any countries on daily basis.

I would have sent the ATM card to your address by myself, but I lack
the time to do that now because I have to urgently meet up with my
business colleagues in Russia. I will be heading to the airport as
soon as I send you this email because I will be traveling out of my
country to Russia where I shall continue with a petroleum business
engagements.

For your good, I left the ATM card with one Mrs.Sumon, now go on and
contact him through his email address so that he can dispatch to you
the ATM card at your contact address.  Simply contact Mrs.Sumon
immediately so that he can send the ATM card to you. Below is the
contact of Mrs.Sumon;

E-Mail:  mrsceline.sumon002@hotmail.com

Name:    Mrs Celine Sumon

I will no longer be able to email you again.

Bye and best regards,

Mr Ududonka Ahmed.
