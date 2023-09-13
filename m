Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698879DED4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjIMDy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbjIMDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:54:54 -0400
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9C1719
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:54:49 -0700 (PDT)
Received: (qmail 131069 invoked from network); 13 Sep 2023 12:54:47 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.101)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 12:54:47 +0900
Received: (qmail 62196 invoked from network); 13 Sep 2023 12:54:47 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 12:54:47 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913125447_297661931>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, fido_max@inbox.ru,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mwkim@gaonchips.com, perex@perex.cz,
        robh+dt@kernel.org, tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Date:   Wed, 13 Sep 2023 11:53:43 +0900
Message-Id: <20230913025342.1460157-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bf43b771-35e3-1b37-24f5-e21b2c34a415@linaro.org>
References: <bf43b771-35e3-1b37-24f5-e21b2c34a415@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Bindings are always separate patch.

Okay, I will send v2.

> This was not tested. Missing vendor prefix, type.
>
> Anyway please provide some explanation why this cannot be deduced from
> the compatible.

This is not dependent on a specific vendor, 
but is intended to describe 
the properties of the signal(single/burst request) connection 
relationship between i2s and dma.
