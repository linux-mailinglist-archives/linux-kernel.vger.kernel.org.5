Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CD676E300
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHCI1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjHCI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:26:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E636C2D49
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:23:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B92D6607194;
        Thu,  3 Aug 2023 09:23:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691050992;
        bh=oK9desb5EWhnphr9ikanL/R6Rwryfv81Ndw2kNrxKEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WiQJxg4TgF966hL+X2NGTvpIhFDRhPoSiwl8sARMWo+MlrvjqefrCzxXXu6/FLfKz
         dQtKFkn2sWI9+NvVVBPxXYgFq+iVrBunxOtQhVgydcCnQaCsBK4KsLZJlxf1fVVll9
         mcfkwQVQfNfQXkOK0RWU3ShDGt+Uw23Lyp2O09aTw71SxmLqwgEhs/W2Y2KaxzsouB
         dH/V4xDWsIhPMTgOz8xXq4pOCTvECEgLyVTwgleLMF9xxEpzlhiwYFBXzeGdOjkqY1
         6niWPcZgyNaCi35hRrDHfSixUs/er4+s0yjVHhJ/bWd5hwD8t7AaBkJn0P9/C5PBYv
         Atrem9ZJAK9zA==
Message-ID: <f345b310-94c8-e3a6-58c0-770569152a92@collabora.com>
Date:   Thu, 3 Aug 2023 10:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] ASoC: mediatek: mt8188-mt6359: add SOF support
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230803052607.25843-1-trevor.wu@mediatek.com>
 <20230803052607.25843-4-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803052607.25843-4-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 07:26, Trevor Wu ha scritto:
> SOF is enabled when adsp phandle is assigned to "mediatek,adsp".
> The required callback will be assigned when SOF is enabled.
> 
> Additionally, "mediatek,dai-link" is introduced to decide the supported
> dai links for a project, so user can reuse the machine driver regardless
> of dai link combination.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


