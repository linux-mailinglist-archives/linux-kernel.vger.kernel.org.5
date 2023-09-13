Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2779EDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIMQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjIMQEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:04:11 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9DC95;
        Wed, 13 Sep 2023 09:04:07 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 609B586A27;
        Wed, 13 Sep 2023 18:04:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694621046;
        bh=Z2IjWn+eoAIoFOZg8W3DakYsk5dq5rFonV8eLvmuXRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xu3/br7w6+z7+B86XApzfGZwJY9O3DvJOYHMf/1zPGmUNWYkp2IE16760MNcmypJl
         KUbLiMS0D9Wu5jClNzGQXGd3JtwloInWXEb4l24vcwCFP1lfMvBmBOFFxTfkI4A+90
         nLZQh18mY1Obh85IjSXh8KV3i2NegvecQ3VIzzE5KTWyTcZbcuSRlwQXh/IQX2MG2M
         UaCoy6syt0x0tgQaZYCSnmLcq3zB/ES1KGPVuOoS6UBSnOMLxc49MTXfzO3Ae2Dq+N
         qbloTOcfk/hGuM6HYGps3o+FaURFWXchWbCmJDEgEhJ3ahktPPke9ACRQnc86/GEy5
         BGwIXpY+bJa/Q==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Sep 2023 13:04:06 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
In-Reply-To: <ZQHbm4K6tDs6ILo+@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
 <ZQHbm4K6tDs6ILo+@valkosipuli.retiisi.eu>
Message-ID: <19523723a202647d0ab5135581f5090f@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 13/09/2023 12:56, Sakari Ailus wrote:

> One more little thing. Do you have a driver for this device? In 
> upstream
> there doesn't seem to be any.

Correct. There is no driver for OV5642 upstream.

The DT folks asked me to document the OV5642 binding even without an 
existing driver.
