Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95D7D4A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjJXI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjJXI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:29:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B3C9F;
        Tue, 24 Oct 2023 01:29:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5BB566072F1;
        Tue, 24 Oct 2023 09:29:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698136167;
        bh=y6VQewPIt6l+bjj3DnPMyynt5aWnCBl8s5jWO+bDUOM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NRTXXfLVPezJQBP3em8vk4+lrxWFVXd5zmibFfHwIXDlZf39BQJN2dOLTfgIrgEvp
         cVhfOszGsMBPHWlqYMva/TtD/IeXaQ5apoe3LG6eeZ+IfVD3SbjUllbqJpaBvWvO+A
         TSSnpYz8XWANuuDznv25Syg9J76Sj32qvoUw/spfCsgoeVmroBv2ah48ACzLnJMi8x
         tAVUqh3dspHH3CtjMnX1LX6S9UFxlRv2r2mWgjL5kQUPc0TLd/B4ef6bCOIO/P7s3i
         FyIZPtXXG9xY3Armm3LLkbtWhI211fnYYNfpYM16co2gtGy6LVNYYZiwpp10K+y9bM
         d8BsI4F+bDt6A==
Message-ID: <624ec4b3-1b0b-4880-a0dd-2379d3c3d0c0@collabora.com>
Date:   Tue, 24 Oct 2023 10:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: mediatek: mt8186: remove redundant
 assignments to variable tdm_con
To:     Colin Ian King <colin.i.king@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231023151704.670240-1-colin.i.king@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231023151704.670240-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 17:17, Colin Ian King ha scritto:
> There are two occurrences where variable tdm_con is being initialized
> to zero and the next statement re-assigns tdm_con to a new value. The
> initializations are redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


