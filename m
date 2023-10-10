Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6207BF01E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379338AbjJJBNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379287AbjJJBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:13:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA282BA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:13:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05391C433C8;
        Tue, 10 Oct 2023 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696900423;
        bh=HQI/CkOWxUANysU93x/AavyAUbaYUiGO9BKt1/wbskE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Feb2zuK8uSwqC19B4iQPybpVDIDebG7RdqkZ0gN814L2rXlrGMmMjPwzkevbsqsjp
         H0W+UmsXNrqp9Ie6iGWRqGTw77OrMtytAKGhtuKgp76FZZU4VsK7vWKKO+2hSB1LcI
         f/2WO6Xuw+HiI0A9TcDY3bd20I1qXshu5HR0EEdYWjl+lpVwGeEfQivLeEumTs6o62
         hgDIEXM6EY+Rutvqupvb6+BmkORLyVFDdTU33Q6YZ291Nq/uLFmFab/spd9nQCRv91
         EheaMQae6iirSijKjYNryL5x8SB7sOTtVMnpgKHHUWXP7OxmjFyBwnL8Ys7LK0kf65
         3CMlgLdLEK32Q==
Date:   Tue, 10 Oct 2023 09:13:31 +0800
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
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-gw5904: add dt props for populating
 eth MAC addrs
Message-ID: <20231010011331.GM733979@dragon>
References: <20230926194110.1451416-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926194110.1451416-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 12:41:10PM -0700, Tim Harvey wrote:
> Add device-tree props to allow boot firmware to populate MAC addresses.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
