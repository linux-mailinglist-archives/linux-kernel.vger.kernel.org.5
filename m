Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18600785EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbjHWRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236177AbjHWRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:39:04 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C9EE7D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:39:02 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c504386374so4291872fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692812342; x=1693417142;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uur3siBT/RlSi8V3RKrJyBH6mseIZQugn6wtUua0SSI=;
        b=TSChiJWU8D+nCZ8bmV0z+tBSJUyeCtGekaJJFrFv0+ZsqI+hEuyN9/ZpsNb+TCJlrq
         hWfCWAuB7HdlLUVBdSS85zVco23kFUFysHLuwBnEkBtNPf+koGC7uSiLT/Tsk9Cr/mKh
         ssADNrmqnMS13lWt2bKgJUT0tdGCr+egA8iNX4fwkG/PHNmF58bW/ZnxO9R//8vw+0/K
         /hy/YQOn6lssKKnHMWOX5GDm2jJA9hqyTFpZXK3hat2kWOYWo5f20lYMbaxWihXDje/U
         UHQ4EMxvWWA8jNugnoxGyVlx0bSws6KMPY1yM16hB4DNxs56AzPujNrGs/ur7h/Rrj03
         OSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692812342; x=1693417142;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uur3siBT/RlSi8V3RKrJyBH6mseIZQugn6wtUua0SSI=;
        b=I+0U8t+QrMQY/qwp2QIY2T3o+/lHpkNBoWK23dD/Mu18ZRKPdmHjR7a5ORlpLarKQ9
         1+plNmZ1XgcJgomqos44goIsO51ygqtltU9vzJhm3ymOX6Kqw/ws01e1m+cnDCAXAe3Z
         cbnunez16qxTYH6BjqACzDOzeMgoggZJyet2lC8T2lV30ilxz/81xfvKEfKCYpw+K9nM
         IcvXTkZKtNHo/0fHOTclP+iU49O11plAQMVqoeQ/eiCn3/K+VxRUnjgrm5CdLfHQupXb
         r3gxfgn/PhLF8/0s4jTAcStQLd9YlxU+nyiEANM9jbXUKFLmWAQIagWMF9lHXkIY0TZk
         Shcg==
X-Gm-Message-State: AOJu0YyxGBo7338bva3FwuVGIu1s53jstJFoSOEKY1VWRLpkZNgDJRze
        Nw8Rl3E/sF0C0Yhkf7UhcCyutDbOlujahdFTB64=
X-Google-Smtp-Source: AGHT+IFn8UeDTGC8yTpMCqPypqHLCdpDEhyTSIWitlBg2FCmpYFvvg/Vg+NFWOVweRDEA1PXaS1jHm/27eTYklFH95s=
X-Received: by 2002:a05:6871:821:b0:1b3:f1f7:999e with SMTP id
 q33-20020a056871082100b001b3f1f7999emr17972674oap.45.1692812342017; Wed, 23
 Aug 2023 10:39:02 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsester2008bf@gmail.com
Received: by 2002:a05:6359:678f:b0:139:9571:fb56 with HTTP; Wed, 23 Aug 2023
 10:39:01 -0700 (PDT)
From:   Gabriel Esther <gebrielesther2021@gmail.com>
Date:   Wed, 23 Aug 2023 10:39:01 -0700
X-Google-Sender-Auth: TAo0BTd53rg0lSn4kC2VH7ydxSs
Message-ID: <CAAq1dN_o3K99QZzG3H5QOe_Kz3BUksrfoqt+1fcQ4GHQqTBhkg@mail.gmail.com>
Subject: From Gabriel Esther
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2001:4860:4864:20:0:0:0:32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5090]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsester2008bf[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.7 HK_SCAM No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Greeting to you my Dearest,

Please I need your help and Assistance. Permit me to inform you of my
desire of going into business relationship with you. I am Miss.
Gabriel Esther, the only Daughter of late Mr. and Mrs. Gabriel Kadjo.
My father was a very wealthy cocoa merchant in Abidjan; the economic
capital of Ivory Coast, my father was poisoned to death by his
business associates on one of their outings on a business trip.

My mother died when I was a baby and since then my father took me so
special. Before the death of my father in a private hospital here in
Abidjan he secretly called me on his bed side and told me that he has
the sum of TWENTY FIVE Million United State Dollars (USD. $25.000,000)
deposited in one of the largest security company here in Abidjan, that
he used my name as his only Daughter for the next of Kin in depositing
of the fund to the security company.

He also explained to me that it was because of this wealth that he was
poisoned by his business associates. That I should seek for a look
foreign partner in a country of my choice who will assist me for
investment purpose. And the money is in six 6 trunk boxes there in the
security company now.

I am deeply here seeking your assistance in the following ways:

(1) To stand as my late father's foreign partner before the security
company for them to deliver the 6 six trunk boxes that contain the
found to you in your country.

(2) To serve as a guardian of this fund in the trunk box and invest
them into a good business investments that can benefit you and me
since I am only 24 years old girl, I do not have any idea of any
business investment!

(3) To make arrangement for me to come over to your country to further
my education/study and to secure a resident permit and my travelling
Visa to come over and stay in your country.

Moreover, I am willing to offer you 20% percent of the total sum as
compensation for your effort/input after the successful delivering of
the trunk boxes from the security company While 80% percent will be
for me and my Education in your country.

Furthermore, please indicate your interest off helping me out for I
believe that this transaction would be concluded within fourteen (14)
days from the day you signify your interest to assist me.

Anticipating to hearing from you soon.

Thanks.
Best regards,
Miss. Gabriel Esther.
