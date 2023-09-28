Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA99C7B1B08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjI1Lc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjI1L03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:26:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20431CC7;
        Thu, 28 Sep 2023 04:25:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DF68660733B;
        Thu, 28 Sep 2023 12:25:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695900302;
        bh=K6uA1PO8CD/Zwv6tLLlM5khcBTgGIA3EYervuYZ7weo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W5DK82oYNHEpgnZPzpKhwCKqI0G48jbuv7hdWqHvHIQXDQ4JGtrpdsvHWv8bYvps5
         xQVI3jerDS0Aa2DIrkHjxeKer6Y+1KJy/iJ2srGQk/QBHj73o1GnNudrMppfgRrruG
         VbePDRoTU1usKr7OSDYBoCdocm1R4mhyWosjXfwFidDUNLXyX9G3waodxx4apJOE2k
         4OEs3nn4lcGIQ1gTGoB7YmXR1EbGIDkcvuGX5R3+w2LHHF5c5bA9dNZ6jRgWhm4J44
         a58F28Kj6STLIWAaBuRV7mSKS+ZE2nWZW4NsDypnu9IMkCJ2JPYCZhflqOVgOMUf9z
         HjwNh/2HYqNQg==
Message-ID: <479f9812-d8df-ed05-2bd6-e871e6175a82@collabora.com>
Date:   Thu, 28 Sep 2023 13:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 1/5] drm/panfrost: Add cycle count GPU register
 definitions
Content-Language: en-US
To:     =?UTF-8?Q?Adri=c3=a1n_Larumbe?= <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        tvrtko.ursulin@linux.intel.com, boris.brezillon@collabora.com
References: <20230927213133.1651169-1-adrian.larumbe@collabora.com>
 <20230927213133.1651169-2-adrian.larumbe@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927213133.1651169-2-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/23 23:29, Adrián Larumbe ha scritto:
> These GPU registers will be used when programming the cycle counter, which
> we need for providing accurate fdinfo drm-cycles values to user space.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


