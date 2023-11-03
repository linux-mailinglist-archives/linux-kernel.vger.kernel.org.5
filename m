Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E747E0173
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbjKCIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjKCIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:31:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237711B6;
        Fri,  3 Nov 2023 01:31:34 -0700 (PDT)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 880C866073C9;
        Fri,  3 Nov 2023 08:31:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699000293;
        bh=dXoBAp6cANz5ixVEHCKSWlWdIcm+4V9e/rNzZfw5NHI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T30BMCPxznWEchWu1VsN19mtmB91HWaSDJ3wfCPr0DXE00/zxWIuJpn/XlHO4g7eB
         UA2Y97RVqc3AUKi21c8vuUpUL6KkOhy9o4ccyfbbWyC1dtyv9tcZvxDDTUz1d4XYkI
         lBd4Bg6wYjX7hpRjgUZHJ0citkSdo2XAPSiMi0/LOvu8Tg/R4H9eee26n928zFDLc9
         rAz/lAT/uJ8mB6dnhlSykYl8+47tUBMh12r/Pw3JVjw1rdrms29afw54sJlC/uKQf5
         cV3NMlFhFlvLi8aBUumwgER3EHDoDatvuqVF/dc085Mp/KPXcfGx1jCO5yn1UIafFZ
         TVUKMxlQBw6ow==
Message-ID: <5f679a5b-66d7-4b75-9647-0a9b926241f1@collabora.com>
Date:   Fri, 3 Nov 2023 09:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: sof-client: trivial: fix comment typo
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20231031112218.79136-1-eugen.hristev@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231031112218.79136-1-eugen.hristev@collabora.com>
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

Il 31/10/23 12:22, Eugen Hristev ha scritto:
> Fix typo s/depndent/dependent
> 
> Fixes: 6e9548cdb30e ("ASoC: SOF: Convert the generic IPC flood test into SOF client")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


