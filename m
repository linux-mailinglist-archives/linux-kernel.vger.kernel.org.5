Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA7B7BF0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441818AbjJJCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379355AbjJJCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:19:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0993
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:19:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51C7C433C8;
        Tue, 10 Oct 2023 02:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696904360;
        bh=isG3Fa6ApHHdE7JhYIYsKZ6nDW2Wv1sB+aWPuiKySrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cn/Od//DQjDNmsM29PunZtiIerpn34+QUww61e5IbuD0bLb7+OHN0UZF38cXv4Wp7
         AlgX/l5kztmuQ7s3Di3FOxdp2HfJ/ZBkSo4e/osdT/AFHxa12jVm3yoO/Ohx6QDzjk
         yLb+enCQnxrR12XkMly1R+hEx9lC3vVaq5PO2wiTWeiUCbAvMhCWCp7FSUeKONFxQ9
         Ai33pOY8Po7jTEL+961ycKWbqV3wb5DCMtuzZTwK1IweaETBqSV/z0Zn0AnU57ekFW
         gVIu8DQZxguoPCRpSoAVhglUdaHz6OsVLo6bc0zOqysp2oUIbShmOaqgvR3Jk61XxD
         1vhoXBUcqHErA==
Date:   Tue, 10 Oct 2023 10:19:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/5] TQMLS10xxA support
Message-ID: <20231010021907.GH819755@dragon>
References: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:43:49AM +0200, Gregor Herburger wrote:
> Gregor Herburger (5):
>       arm64: dts: ls1043a: remove second dspi node
>       dt-bindings: arm: fsl: Add TQ-Systems LS1043A/LS1046A based boards
>       arm64: dts: freescale: add initial device tree for TQMLS1043A/TQMLS1046A
>       dt-bindings: arm: fsl: Add TQ-Systems LS1088 based boards
>       arm64: dts: freescale: add initial device tree for TQMLS1088A

Applied all, thanks!
