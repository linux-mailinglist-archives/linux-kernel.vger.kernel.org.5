Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B07A8379
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjITNdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjITNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57084DD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:33:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DACFC433C8;
        Wed, 20 Sep 2023 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216823;
        bh=kEtomxCuxS+RtMOIXKQtIQVfIDOZG16wGei4amN4ViQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ZXBrSAQVUdpQoSymm9p0RqXB8xJjpA65T/07k+ntRqkJ2yXlxxAQv5m92qwdn3mRu
         iJ73eMpGi2YHAgIM72P4vOOMBV4dCRPQdsnfDPPY7fgIW3OlgF3HvrQFaEGl0bZKo/
         lzoPVS3RVHfF3mB7B1fX3BdA0J8+pw0teHzCUliaJ783IgbVupOK/FrS0UQd+TuJc3
         +gPxk5kaa1fWdhqUD8DCHQZ3d43F8iQ3LYJGv4q2adplZZRvGGLcW7jMxQ8uDJpchB
         S4dRX90iXKft/zrT0VsJkcfyZaaru4Yk311tI3YiZpTdTdlfmpYEOVJ5Luw/klvjzs
         VoNaOWPteYccw==
From:   Lee Jones <lee@kernel.org>
To:     sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, lee@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manikandan Muralidharan <manikandan.m@microchip.com>
Cc:     Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
        Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
        Balakrishnan.S@microchip.com
In-Reply-To: <20230915104849.187146-2-manikandan.m@microchip.com>
References: <20230915104849.187146-1-manikandan.m@microchip.com>
 <20230915104849.187146-2-manikandan.m@microchip.com>
Subject: Re: (subset) [PATCH v5 1/8] mfd: atmel-hlcdc: Add compatible for
 sam9x75 XLCD controller
Message-Id: <169521682037.3438630.9896285610873837509.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:33:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 16:18:42 +0530, Manikandan Muralidharan wrote:
> Add compatible for sam9x75 XLCD controller.
> 
> 

Applied, thanks!

[1/8] mfd: atmel-hlcdc: Add compatible for sam9x75 XLCD controller
      commit: c743c12c79ff716e081095c5a2ba360e42b39d78

--
Lee Jones [李琼斯]

