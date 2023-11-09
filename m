Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52C47E6940
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjKILK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbjKILKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:10:54 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0382D71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:10:52 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9d10f94f70bso118937166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699528250; x=1700133050; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN+QwfT+xQWh4cuURiHFidYHq5dXkXMupE3QwniMIHk=;
        b=GuTRiYBPaEigiSEaOPLiSCirkf5Y3kPfuspJKWIfmop2idKwx+AUPurvGmchcY7A/r
         8ApVg/iKULd89fESTUbyOXGApIEf1tBJD3+agBlwsN4Jkp1hwUUVheg3F0ep4scRgfvw
         2Tfy6UrZK8WRbr79UbV2TDDIGUM+UgIxc7d2Y40/QxV/Rum2uIB13ymXpyk7jA5XA+K9
         7dICh3FIo9HCj31KQARrHUfWf6scqzdvG0HyYHqAXjZ60p3CW4/20CmZJHuk4h5shu5Q
         J9X4PhICrDqA2EyQ3Xx53sNFuDpAEpbMN6rt5U4201/4dSzewAhm2wqBBUh3Y5TCSb9o
         Vx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699528250; x=1700133050;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rN+QwfT+xQWh4cuURiHFidYHq5dXkXMupE3QwniMIHk=;
        b=GFI8qswbfHbWovPZ13+1vyTXOG5svqIkX8qVP8dNDBItrsvOKydD4GbWai87d8GA3q
         mlOWOmyFpXO+rHLUq5Cek2r0SHeDidK/likOlXRYvlWVowOe6RorUaZjCd/+GNiNSiAU
         vBrij/LkepZYLifTAugxlGIRp8yhSHdbGQOZ7j4s3EpitJJbKlSzBFcjfmAKU+KiH1lt
         XpRpjb/ifGgEkmv6G0ZYJLQ7gueXcck90NFGy8gKqAfktF0SZQAy7vILB5XtmoWKdbj+
         FC7heOX7yFDUYLFAWyHarWJQPBotxf+cUBVnLO0/6KKTwKGRJJmDMg5UCkGNs8S3/rNP
         tpzQ==
X-Gm-Message-State: AOJu0YxjsmUzcsYDFhvnGf9+DDYB94nyepUSzLZLwGwI1o4wcSE7192S
        b/pL0JZ813vkBje6SQOV4FO9tdLHkV+LU8yB6aM=
X-Google-Smtp-Source: AGHT+IHDxgI1k2LJn9iBPHYBLi6twnuqKW1/+XDukyiRR0ddbga2teY8d6OpEAN+K2XgLcdN0rTeR6qlYjxMdHNmDxk=
X-Received: by 2002:a17:907:a0b:b0:9e2:8206:2ea9 with SMTP id
 bb11-20020a1709070a0b00b009e282062ea9mr3453249ejc.60.1699528250281; Thu, 09
 Nov 2023 03:10:50 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7412:598c:b0:df:929:60a6 with HTTP; Thu, 9 Nov 2023
 03:10:49 -0800 (PST)
Reply-To: alimaahamed444@gmail.com
From:   "Mrs. Alima Ahamed" <parkhood58@gmail.com>
Date:   Thu, 9 Nov 2023 12:10:49 +0100
Message-ID: <CAPHQXebSpvWVFuKgudK5heZiGDxf_m1W6Ypn8xVfNtX1mPca9A@mail.gmail.com>
Subject: be very fast about this please
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear friend I don't have time again
It's my pleasure to have contact with you based on the critical condition
which I find myself, though it's not a financial problem but my health
condition, you might have know that cancer is not what to talk about at
home I am married to Mr. Abdulkarim Ahamed who worked with Tunisia embassy
in Burkina Faso for nine years before he died in the year 2008.We were
married for eleven years without a child. He died after a brief illness
that lasted for five days.

Since his death I decided not to remarry because of the attitude of his
adopted child that do away with some property as the only son, when my late
husband was alive he deposited the sum of US$17.5m) in one bank in Burkina
Faso, Presently this money is still in the bank. And My Doctor told me that
I don't have much time to live because of the cancer illness, Having known
my condition I decided to hand over this fund to a responsible person that
have fear of God to take care of the less-privileged people with the fund ,
please if you are trustworthy  and willing to take up the cross and utilize
this money the way I am going to instruct you indicate, here I want you to
take 30 Percent of the total money for your personal use While 70% of the
money will go to charity people and helping the orphanage.

I don't want my husband's efforts to be used by the Government. I grew up
as an Orphan and I don't have anybody as my family member, I am expecting
your respond, contact me through my private E-mail
(alimaahamed444@gmail.com) for more details.

Regards Mrs. Alima Ahamed
