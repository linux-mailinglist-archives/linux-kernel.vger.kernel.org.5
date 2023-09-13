Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2676D79E03A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjIMGuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjIMGuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:50:07 -0400
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21E1980
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:50:01 -0700 (PDT)
Received: (qmail 96810 invoked from network); 13 Sep 2023 15:49:58 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.37)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 15:49:58 +0900
Received: (qmail 192671 invoked from network); 13 Sep 2023 15:49:57 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 15:49:57 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913154957_8612192425>
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
Date:   Wed, 13 Sep 2023 15:43:07 +0900
Message-Id: <20230913064306.1862804-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <644e3564-994d-0b51-7d58-dac6afc1e0ec@linaro.org>
References: <644e3564-994d-0b51-7d58-dac6afc1e0ec@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is not dependent on a specific vendor, 
>> but is intended to describe 
>> the properties of the signal(single/burst request) connection 
>> relationship between i2s and dma.
>
> How does this relationship depend on hardware?

When designing a SoC, it depends on the RTL and Bus connection.
My company has two types of configuration SoC: single and burst 
to meet ASIC customer's requirements.

Thanks,
myunguk

