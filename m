Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA227F13B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjKTMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:42:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961F7F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:42:30 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D31AE6602F24;
        Mon, 20 Nov 2023 12:42:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700484149;
        bh=jjaPVx0eDtJkqek6Qcbfsk77mrZMKU5PurUc9yQS84I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JB3428zAWwfdw43PhTxaLcOxcIf4+4V6+sSKGWtBUKslsB6egKUY3S2yfCibHjIq0
         zPmg41BqqBnQ8fL+4iDibby3cEUrSdwRWVydMmIu4iosQRx6GkHyRvWLA21pDgGeh9
         NnBPdksfrnrZvfZUnMEBVdf1CRd60HX2CrAwbma/Oz7alDhrwqTPUqUVgkvheExXtq
         cr/z+jQJp6mQ/tUS46CHc1utH2VvkzN+xRbwjbC5UTiGYaGgXWToWaLBoyxT2ogkmM
         Qu9iTlrxakFEMOk0rzUoZKRL0F9qxB6PS98QPyY6Ztj3AFYOgwfWarlgFWFcYOrNXu
         rL1mU4/IhM/Tw==
Message-ID: <af969e1e-7412-4f2c-815e-3d473eaf5c8f@collabora.com>
Date:   Mon, 20 Nov 2023 13:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: mediatek: mmsys: Add support for MT8188 VPPSYS
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231117054345.15859-1-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231117054345.15859-1-yu-chang.lee@mediatek.com>
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

Il 17/11/23 06:43, yu-chang.lee ha scritto:
> Add MT8188 VPPSYS0 and VPPSYS1 driver data.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

