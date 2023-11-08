Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333C7E588C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjKHOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjKHOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:19:33 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C31FCA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:19:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3b4145e887bso3674469b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699453167; x=1700057967; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxMPqQ69MgB9H8744DRgZXodDHNSAgdATXozoOPaNVI=;
        b=LjiRXdCI5zK1pj1UhGMPw/Uuwj72+JG7eJ6ZW/W1T/IssQY519kBvLO6gbuvqqa0d8
         lCUN+YE+dS3QQfo7S5z5y0V2s0Vn4JFrvHUoNA2EV4oSBHEqYvYs1RsG/hvp5JX5ETGK
         mUUkHgX6FoPLkeyiPEju9AukfWJSRNXaabHt2FS+yrMQ0rZm7MnCF2S6zlYsG98XtUDW
         YvtxBAZ+HvRPBgt5uLi+FBaFwAODNdQtfTni3jXodfhslj0CQE3X72+GgPvqCwYHnsav
         7SQaabHkn6Qthb8JcTo2y/E3B0X+TykuV6v0NJ8BnG4z+X9NbM1AuFD7xTNsAQkdK7kO
         vZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699453167; x=1700057967;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxMPqQ69MgB9H8744DRgZXodDHNSAgdATXozoOPaNVI=;
        b=Vbir1tfMb3yjLEmLvQl1OKei3YYgxHAN37tF0r/m6hfmEip4kihSEnoUKIXLSu1f9s
         GVqSKwvWi9ihkfThxOm3YUpRsBCKeWgpSalC0G6MPCZRCRN71/uiNa5j1piVhYFfPvhm
         MVbNSLMYL1me+VfJ47TG/zlkTRWCyFJRMoMT2TvdgoIU83t2kQzHKExvFDJhUD63rpI4
         iTaAUIE6k9q9HZSAxlXpAGAtTMobv//ECJIcO4NJ45rQ9fHg0M7zL6kkvCXTcUyYA57y
         j8ZJT2M5ccog1yZva0/YnkJDEFfzM46u8DOXNcPk02lwxKq/sGuaF6OG281c06Ffv3ZM
         2kTQ==
X-Gm-Message-State: AOJu0YyV0SEoiePC+tPNIZusLDaq6ffSccTsLWy1JCHQ4qx5ftH4ocxa
        BcgNVBhpFqfVWaaI7dqlUUo0z3WwHpDQAJWPnZ8=
X-Google-Smtp-Source: AGHT+IEygPASBKUdiBEszeYYHGp+sq5K8kmSP35crO75MbtwIMhrfwRGumpiVeND0A1/NXL5ggyJqTKqwUs+W0fGxC4=
X-Received: by 2002:a05:6808:9a6:b0:3ae:55e6:1e34 with SMTP id
 e6-20020a05680809a600b003ae55e61e34mr1860247oig.58.1699453167524; Wed, 08 Nov
 2023 06:19:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:6106:0:b0:4fb:55b8:e237 with HTTP; Wed, 8 Nov 2023
 06:19:27 -0800 (PST)
Reply-To: Westernunionrespond@gmx.com
From:   Faso Liza619 <damembaye.dm55@gmail.com>
Date:   Wed, 8 Nov 2023 09:19:27 -0500
Message-ID: <CAJW_e-a8U=-by3J4anD+nYxcsvJ-Fp9RC3ZkBhN-2cxfbnS=Kg@mail.gmail.com>
Subject: Payment Through Western Union
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GREETING:BENEFICIARY





You are welcome to Western Union Money Transfer head office Burkina Faso.





Am Barr Liza Faso by name, The new director of Western Union Foreign Operation.




I resumed work today 6th of March 2023 and your daily transfer file
was submitted as pending payment in our western union office and after
my verification, I called the formal Accountant Officer in-charge of
your payment to find out the reason why they are delaying your daily
transfer and he explained that you was unable to activate your daily
installment account fully.



However, I don't know your financial capability at this moment and it
was the reason why I decided to help in this matter just to make it
easy for you to start receiving your daily transfer because I know
that when you receive the total sum $2.5 million usd that you will
definitely compensate me.



I don't want you to lose this fund at this stage after all your
efforts. Most wise people prefer to use this medium western union
money transfer now as the best and reliable means of transfer,Kindly
take control of yourself and leave everything to God because I know
that from now on, you will be the one to say that our lord is good, so
I will advice you to send me your direct phone number because I will
text you the MTCN through SMS and attach other information and send
through your email box, including all documents involve in the
transaction.


For this moment I will be very glad for your quick response by sending
sum of $25.00 so that I will quickly do the needful and finalize
everything within 2:43pm our local time here, I am giving you every
assurance that as soon as I receive the $25.00 that I will activate
your daily installment account and proceed with your first transfer of
$5,000.00 before 2:43pm our local time because I will close once its
5:30pm.


Be aware that all verification's and arrangement involve in this
transfer has being made in your favour. So I need your maximum
co-operation to ensure that strictest confidence is maintained to
avoid any further delay.



Send the $25.00 through Western Union Money Transfer to below
following information and get back to me with copy of the Western
Union slip OK?



Receiver's Name...............
Country.... Burkina Faso
Amount .......$25 USD


I felt pains after going through your payment file and found the
reason why you have not start receiving your fund from this department
and ready to do my utmost to make sure you receive it all OK?


Be rest assured that I will activate your daily installment account
and post your first $5,000 USD for you to pick-up today as soon as we
receive the fee from you today.
email respound.   Westernunionrespond@gmx.com




Yours

faithfully,
Barrister Liza Faso
New Managing Director
Western Union Foreign Operation
