Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C77BF042
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379320AbjJJB22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbjJJB21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:28:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF13A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:28:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798A2C433C7;
        Tue, 10 Oct 2023 01:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696901306;
        bh=TLlwIHP3MWnMGtGEksM71x3c/26h+IpM/6jx10p9hgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XkzdJXF6gQzwwkio4Dd/r2oRfkN4P19bfIBCmSzCHP1piR8FK867nA0n16qjA04l+
         ac1IJPMg/mIJB/O+iDGGRyK27SqgeESLHpL3S/mnyYJZlbjhu9z/zfVhJPVlXv4Rtf
         aLmtTeblI6VQi8ULVijqT1kesxi4/xHVfzQsrELqvuc4mXbzqrETgrexjjHSgjNAPH
         WteVetZnHjF4R74322mMVCgfnafOIpjeBlSJcqAL3SpTUBoqCq7SYKQ/3vwuk5DoSA
         RiOJlAs2DpFSQ2aSBKaiNf+R8sVVB9x5OP1JS/Ux9Ypo2mloD8dqF9KziH3saYcm0l
         m62NWoYeWhXzg==
Date:   Tue, 10 Oct 2023 09:28:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp-venice-gw73xx: add TPM device
Message-ID: <20231010012815.GR733979@dragon>
References: <20230928201354.1946035-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928201354.1946035-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 01:13:54PM -0700, Tim Harvey wrote:
> Add the TPM device found on the GW73xx revision F PCB.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
