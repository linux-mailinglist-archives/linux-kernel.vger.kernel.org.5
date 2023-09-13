Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19979EAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbjIMOYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjIMOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:24:12 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A27289
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:11:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so110960731fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694614300; x=1695219100; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C321/cfg/f7c5esgrz3dlVUWp6WruYXG3a348g1J+F4=;
        b=dcnLuT+u9Ou7Ku7PQptWJN/qlFV04XBDYsm92HsMqjF3N24cia6+ADyZxytD9/7F1Z
         bEM4kLbV//UOBqpkMv45Z6LK4aQWS65T6rXK9brZ7qXFqgOvxma1DGTtwx8CZCzIa8/Q
         bbyKXKlEA0/3y2J2rXGQekGn6VstiiwHKrpwHZMdw9QldhzaM/yaJsuaPVgbnGeGSr5C
         0COUY+hC7fIcBwWjdWFRakRiFyLXe/gJsbqnH/vpLpuStkHaOlbx720BLpCokTQTapNO
         V8yJzE8PyFWUKCnhwu4YGu8EdteSy4Xz9y/AcwLXXBa8xFdylWDKzlvvexrfrfbgV9Eu
         I+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694614300; x=1695219100;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C321/cfg/f7c5esgrz3dlVUWp6WruYXG3a348g1J+F4=;
        b=hxjhuehBiVpZEljwxSi5I6FqLH+X+KbiX/bo3K4Yp/gKh4NnFDhRTsl+D+1xMXrUsc
         MxPdHKFLQPp3LgEOhXKCI7YUCvM02DzsDluhViL5tWF6y2tMoOxOtz5SUZwAB5UFcSrM
         V86krhaqt+bgugPQmZxPcLx/aRfgDXOgLBSEIK+IH4gFBK9GHrxV8Artmg084dyj1Kyh
         GQQOEDomKSbfma1AZnhSS0rWRDIAH0ybG/i72WT370ZlJarAt9vjV0R56cjyOBm5wbN6
         +DtwvpnJtPrrQ5+J1EU05hp2xgC3rugwWjeHFY6uqe36NxUshRLl3s6LbM632B3olzwJ
         GDRA==
X-Gm-Message-State: AOJu0YwGro9d3WS2krSZX6aCwSZHnb7KSzkpJcq6kXX5Bc04wdvWVcF2
        x8nopEMiTHNfOFgF9EY4tT2l+pCmHzE91cDp3dI=
X-Google-Smtp-Source: AGHT+IEGSe+tz7mMhI3N99nVu25pqf6fwq83aIUSEsjG1T2YN4aKBn7ePTXazQzdsR30JHjUT8WhbWdieKe2n5zxUtM=
X-Received: by 2002:a2e:88da:0:b0:2b9:c4f6:fdd with SMTP id
 a26-20020a2e88da000000b002b9c4f60fddmr2426299ljk.14.1694614299976; Wed, 13
 Sep 2023 07:11:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:6f53:0:b0:240:3e6d:6c8e with HTTP; Wed, 13 Sep 2023
 07:11:39 -0700 (PDT)
Reply-To: lanbeldamus001@yahoo.com
From:   "Mr. Lanbel Damus" <handasee01@gmail.com>
Date:   Wed, 13 Sep 2023 15:11:39 +0100
Message-ID: <CA+_ejypQAbdQN3YucjuJgbNL7NNKG2GxtE89rwFPVH2O0i3SBA@mail.gmail.com>
Subject: Good Day//../
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

My name is Mr. Lanbel Damus. I am working with one of the prime banks
here in Burkina Faso. Here in this bank existed a dormant account for
many years, which belong to one of our late foreign customer Mr.
Oleksiy Vadatursky from Ukraine.

You can get more information's as regards to this on below website:
https://www.bbc.com/news/world-europe-62367356
When I discovered that there had been neither deposits nor withdrawals
from this account for this long period, I decided to carry out a
system investigation and discovered that none of the family member or
relations of the late person are aware of this account, which means
nobody will come to take it.

The amount in this account stands at $18,300, 000.00 (Eighteen Million
Three Hundred Thousand USA Dollars). I want a foreign account where
the bank will transfer this fund, I will front you in the bank as the
Next of Kin to the late customer and back you up with relevant
information.

What the bank need is proof and information about the late customer
which I will assist you on. his is a genuine, risk free and legal
business transaction, All details shall be sent to you once I hear
from you.

The information as contained herein be accorded the necessary
attention, urgency as well as the secrecy it deserves.

If you are really sure of your integrity, trustworthy and
confidentiality reply back to me urgently through my private email
here: ( lanbeldamus001@yahoo.com ).

Best regards,
Mr. Lanbel Damus
