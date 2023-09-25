Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4FC7ACE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjIYCpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjIYCpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:45:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782C9E;
        Sun, 24 Sep 2023 19:45:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B0DC433C7;
        Mon, 25 Sep 2023 02:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695609924;
        bh=cFiVkeHH8aw7eWa5EWHyA/v7o2wzDHmEyxHYroBLuHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXQSKx7WiRfKY0uiGpOEBoO9yP3oySlL1Wp06OcrxLmb+brEyU3VndtsHxm6mr3vE
         GDbKWt763Mz8aNXw4qwwIfevF4Go+Mrnj6hEAwxuKUwDJe17Te6oFSGIUt9CiXI6c0
         PPKvwp1aACg8MbcaaVm6HOrmbyow/U6M5PADxV6sHGkySzdXW2LtaHNN6uePPTL2vq
         a78tyVKvN+bjfz7R9YzLOtGcYFtoLw0ShhGvEE4gg4LqvaiRPLc7A9QZxLpOfIKYou
         xA/kuBr6BLNb3WCUpjUF9RmMZPrHUWiw8U+3nZ4WIxLVtD5+b8QBCItH816xNKFjsl
         Da9390BPkPe6Q==
Date:   Mon, 25 Sep 2023 10:45:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH 06/17] pmdomain: imx: Move Kconfig options to the
 pmdomain subsystem
Message-ID: <20230925024513.GD7231@dragon>
References: <20230914111731.586564-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914111731.586564-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 01:17:31PM +0200, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc- and firmware subsystem to the pmdomain
> subsystem.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: <kernel@pengutronix.de>
> Cc: <linux-imx@nxp.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>
