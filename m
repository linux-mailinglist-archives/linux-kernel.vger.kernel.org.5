Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7B770360
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjHDOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHDOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:44:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9F49C3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:44:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-267fcd6985cso1428294a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691160259; x=1691765059;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5EcD2rB5xVe292FBOeTZI1wHKkTxbie0Xt0YIpcwWE=;
        b=KpuaZEqhdQUGAAN9pYH60F2QIcqzZQI2gwp8Z03QcN8ze34EPO5YxbFMNo9CHE6MDQ
         6jqkxVokwFen4u6FYWLDAMwl3HO909LcabJLKB2M8NnHP9+9w6RHmQHyXtOaKrm3V7ks
         Wnbfw0/v6tlIdo8ll89O1UK6hSWfTIR5frg2uCTTRcTnamGW/O+5vDkuYTSYOJ2q+vsF
         7EuczoedJ+RrM4o2c9Qxup0a3tYrLLlVX1B7/BXa8TfDmD2/HnmrXBnuImokAy/Y27rA
         aYP/RfxwoqYN52wJfC65LL1ezfWRb4rOAs89V6s2nQjdcT3uvIFit7eDO18eltfE/RoV
         R+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160259; x=1691765059;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5EcD2rB5xVe292FBOeTZI1wHKkTxbie0Xt0YIpcwWE=;
        b=U4gnbkqod4hov2/uau1I+TxSHNwv77mFbFyXiesu9ErB8Kjirljlgw7RBatRm5NVEf
         jwwish8X/IhFycA1jrICbZSoIeTWzpjIfCKq5dapTPGPQHi+3LW0BWBPLICqMis8l6ek
         A4XfU07The3FfHUze1+0eg/JWun8cwHxNgRv0bF4E6bewsenNw7lA1qvZxnCKLoeZMZ9
         W4j23XBxhCSZDW6SZjU5ZFpkAyRsWTgQmceAl4hKbGADqtZFHwB0IHG8YzlqJcleJR8q
         hqfFfmgctmH+0xxRJJbYLJjhQm7cyDJQpKN1pS8CHo5Ogx35glkYUwfVVbha+0q/ONxU
         HdQw==
X-Gm-Message-State: AOJu0Yz/QGbKCm1HQhiCBMW4Bm4gHzrcOaeoB5X0VN+VXcZDX50FuaaX
        D6rG3DUl9Ili1hcNvo6iy0H7S1aWFkUwpVsfUe4=
X-Google-Smtp-Source: AGHT+IH9e/F0WS3EqRFV8TbmOkcFa0QyB4R5fjipj/MqTYGihhHCC0tAlUP6Oz54dy0iq8iHudeYGGK5nM5uqLoe+f0=
X-Received: by 2002:a17:90a:f0d0:b0:267:ee02:4563 with SMTP id
 fa16-20020a17090af0d000b00267ee024563mr1987191pjb.26.1691160259433; Fri, 04
 Aug 2023 07:44:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a11:10d:b0:4cb:bb20:bca6 with HTTP; Fri, 4 Aug 2023
 07:44:19 -0700 (PDT)
Reply-To: drdisneywe@gmail.com
From:   George Francis Edward <transatlanticlondon@gmail.com>
Date:   Fri, 4 Aug 2023 07:44:19 -0700
Message-ID: <CACzprsFohuXjS0ZnN4G2kaFPsEd1D5z1OS6OTTB-Yq_kN7RPdQ@mail.gmail.com>
Subject: Venture Capital
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1041 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [transatlanticlondon[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings and I hope that you are doing well

Venture Capital

I'm sorry for my intrusion, I got your details from the London Chamber
Of Commerce and Industry.

My name is George Francis Edward, I am accredited broker to a United
Kingdom based venture capital firm which specializes in growth capital
investments for existing companies and Start up business, and we are
currently granting loan to medium and large scale companies who need
funds for start ups and expansions.


We are looking to invest in entrepreneurial teams with big ideas and a
need for seed capital to turn their ideas into great companies.
We believe every business man or woman is basically an entrepreneur,
for we all strive to achieve optimal goals using limited resources.

In seeking out worthwhile investment opportunities, We are ready to
invest in project developments and business ventures that can generate
at least 10% ROI per year. Our offer for investment is based purely on
Loan / Debt Financing basis of 2% interest rate per year throughout
the duration of the collaboration.

We have the financial capacity to grant a loan of up to $3, Billion
for a duration of 2 to 20 years, depending on the size and nature of
your business.

Should there be any available partnership or investment options and or
openings for new investors within your firm, then get back to me so
that I can link you directly to the my Principal/funding firm for more
collaboration.

Yours faithfully,


George Francis Edward
