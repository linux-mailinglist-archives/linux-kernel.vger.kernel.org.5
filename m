Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2046F7FD81C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjK2N2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjK2N2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:28:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69C19BB;
        Wed, 29 Nov 2023 05:28:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 310176607328;
        Wed, 29 Nov 2023 13:28:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701264515;
        bh=391JrrSGeUr9291eqzljQo/DgLrHi642hF1rtV4tUW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8YuxjikO+Q2FNYZ3hrnkWv9cv8/7ajn0OcCYlOshuU7VMJKXTtUcAs7LdbmxZPH0
         1UkLmNtwkLnA3OPK69eDjnNdboS5YCwRsUqOyy/fp47gTfnYl/1CioFRSqWHryvyOt
         Wm/IjXfD0KQwW7e/KXyDcxV5pf4I4Alj8JIbmVS53e+xZuFFV0ZO6ci1zvB1XqeSGB
         5La6rvC0HnU+YLA6mfRuQXUQLHR2AP7nrF5PpQ0XvCBImnsh6Ht9cF/Mvip2rIqDIy
         Ql8qeRpDlkRyGSt9AXNAzLnIJsm6KVWcYax3PX3jsJZesSyfk/16mjKgp0ZA0nCum/
         Q1Fp1TCH3RJfA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linux-mediatek@lists.infradead.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        kernel@collabora.com, Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: mt7986: change cooling trips
Date:   Wed, 29 Nov 2023 14:27:40 +0100
Message-ID: <170126437824.153055.7638508509040884567.b4-ty@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025170832.78727-4-linux@fw-web.de>
References: <20231025170832.78727-1-linux@fw-web.de> <20231025170832.78727-4-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 19:08:30 +0200, Frank Wunderlich wrote:
> Add Critical and hot trips for emergency system shutdown and limiting
> system load.
> 
> Change passive trip to active to make sure fan is activated on the
> lowest trip.
> 
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: mt7986: change cooling trips
      (no commit info)

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
