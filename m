Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16179D613
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjILQTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjILQTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:19:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AFF10D;
        Tue, 12 Sep 2023 09:19:44 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-163.ewe-ip-backbone.de [91.248.213.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3594660731A;
        Tue, 12 Sep 2023 17:19:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694535581;
        bh=L0D5W/tgadC/RkHf5dBNuFZWPw8wxQBuzbrUiyXCefM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RVXvd6MkEZiUZ8hGn21O5oH/vG6u9CTXU5k8cbhj9Lpf2ncOcevocrriWjt3XHKzF
         nQ2PnaOTFOdIeL78aPL+9wpSGfZ89tmA4bHx0+HNNDmjU5bn6yLMUDZy/okC80AXSN
         uUI6METp/DtuckEhlIM/hFO4WO9Funxvp2zvZNHGalvYY0uRAiYxykMKo899qn7zsI
         R/6y6dbw/3Sluy79w+wkMt4avst0jhireTVtHRoziD6AJTVKvtMAj3pkHknzykRjZ4
         1qf7BPIJ+BEf+CIEmXtXydVTH4VjK8xlDbU8+9tiPMCwbfNbXngQRS9DEdBt5A8Oup
         pp6cvnwXgsjxw==
Received: by mercury (Postfix, from userid 1000)
        id A8C93106098A; Tue, 12 Sep 2023 18:19:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
References: <20230902202505.97609-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] Match data improvements for bq256xx driver
Message-Id: <169453557966.461789.15641633963969004909.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 18:19:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 02 Sep 2023 21:25:03 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for bq256xx driver.
> 
> This patch series is only compile tested.
> 
> Biju Das (2):
>   power: supply: bq256xx: Use i2c_get_match_data()
>   power: supply: bq256xx: Some cleanups
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq256xx: Use i2c_get_match_data()
      commit: f28992902b17245af042913d6cfd6a1cc100bcaf
[2/2] power: supply: bq256xx: Some cleanups
      commit: 02e673e59c3d374924422f74fb229ae4ee6715fc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

