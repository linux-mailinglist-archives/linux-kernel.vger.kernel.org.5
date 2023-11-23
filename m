Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448467F5D92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbjKWLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344939AbjKWLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:17:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DDB9;
        Thu, 23 Nov 2023 03:17:20 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD3586607399;
        Thu, 23 Nov 2023 11:17:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700738239;
        bh=2iodxh4WFdUN0YUDs8e2jORssg12+fCUm/I386AK+n0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UtE+qT0blWGNvMpufqC2Ubyc9FWynPNxujH3YsMq8FjcF6hy5CTCxElfzz6oeV0sp
         Lqou3s23pBgY8+WDrGh0n6JuLA8ZDWiT/1L6U6leovnk38fnvULQOWtUhPqBaD9yKs
         7avw2udD0LiKgmSs5U0X67ave7Bh1MhfmGf53Xy9MC5ts/o6zUt6YibDSA0sWtWUOg
         WV2WUUXnXgpW3kp71HqVO9nqMu/QevDthr/cMpznrMBEuuExabn2LR7bMAPSzzh0ba
         XVqgdI+yUjWZNEDgEkEFmGHIDCSjwjSZJ15g+NK7GhK7VkHiSz0nonfDluE85sljnG
         gORtC3C2h7j/w==
Message-ID: <0311dcdd-1c70-41ff-b170-dc2782f7ea49@collabora.com>
Date:   Thu, 23 Nov 2023 12:17:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] dt-bindings: arm: mediatek: convert audsys and
 mt2701-afe-pcm to yaml
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
References: <20231016203915.9793-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016203915.9793-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/10/23 22:39, Eugen Hristev ha scritto:
> Convert the mediatek,audsys binding to YAML, together with the associated
> binding bindings/sound/mt2701-afe-pcm.yaml .
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


