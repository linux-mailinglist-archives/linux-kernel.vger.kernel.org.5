Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830A7E4165
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjKGOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGODY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:03:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7D10FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:55:11 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 918F966074D1;
        Tue,  7 Nov 2023 13:55:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699365309;
        bh=gD0fl91BJJYK3GHx/hIeJyQppl6gbLh4shexoNrIjjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QcqO2yXYIc5T2HT+gxP6HwXtEnNzcgSallJ2Z8xbss9ad3Obsd56gxp1SL4XSWAR/
         m/u+Tf8mmUlmyo54ve2QktQ/8pYP6P8ztKS5xp1IyH5bpaH4za2b4yzLvqMMsHD2gZ
         fb0il/thr9lD59BBj4ldFbXxLD35eWQT/TOzE7QrnYwUfLEi0qV2z1qqmBPh5OUoFm
         8ddaNcMnI1D/6iG5W0KRHjXMYSOKxtiTJg8/ro+u9725fzDb5n/QPg+I7gMF7fktZy
         hGEAR+zGjS6XLQgvzuX02uRnO37PUtcHkGX9AGyyfe3dc0820XhDLIKubR0RauVm8S
         ulKBYnU5r423g==
Message-ID: <3b440a39-593d-4426-8268-979d12ae36f4@collabora.com>
Date:   Tue, 7 Nov 2023 14:55:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: SOF: mediatek: mt8186: clean up unused code
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
Cc:     yc.hung@mediatek.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231103095433.10475-1-trevor.wu@mediatek.com>
 <20231103095433.10475-3-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231103095433.10475-3-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/11/23 10:54, Trevor Wu ha scritto:
> Since there are some variables that are no longer being used, we remove
> the code that was implemented for those variables.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


