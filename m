Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1107D7BF0CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441861AbjJJCWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjJJCWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:22:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0472A7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EB4C433C8;
        Tue, 10 Oct 2023 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696904529;
        bh=ut+LM5Yf8/DRNRKaXkXaCaT13oHwtFjxMTdx39BVx4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8Te2yZDb2jJyDqYjPUAf0y90DpqZP4C/VLyHHhDvu50/wzVFwd6sKg68iEWwLlPV
         eE8mNgqcF2P3Vh4/+9XeEdJ0JteJGZMVAei3zZi9YKccWtCUsiK7wfj1gyET0wSy2g
         3TgUTZdvUIhSW6MlGWyipC/rC6VHkna+XnTYN94+ln9PTmcvm93CXz+IjsEGq1TOqg
         P/k5OxSk/AdemQvQ1NKAGtIquGaDMp9zuitJCy5be7TG12jdt+RgECab55UEwZAVUr
         JL3SeK1084zRMdNlIfiPkOej0JEBsAcF0hb5mSXCnUnVcZQry6OHYIzdvASEPmCFhD
         wA+NDmGlQ8s7w==
Date:   Tue, 10 Oct 2023 10:21:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Add sound-dai-cells to micfil
 node
Message-ID: <20231010022158.GI819755@dragon>
References: <20231004230159.33527-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004230159.33527-1-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:01:58PM -0500, Adam Ford wrote:
> Per the DT bindings, the micfil node should have a sound-dai-cells
> entry.
> 
> Fixes: 3bd0788c43d9 ("arm64: dts: imx8mm: Add support for micfil")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks!
