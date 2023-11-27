Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B933C7F97D2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjK0DGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjK0DFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:05:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61EC1AB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:05:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E7FC433C7;
        Mon, 27 Nov 2023 03:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701054349;
        bh=wJFAeOGshFDxEPHQZh6FK2rmzXE1y7l9c9VTtj4pc3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFqQMVQFQ3DjdFUnEJ+P62Q0ZEojQAsFJvYG6U4Gm/577vXfVLZumcRl+IyMTGw/T
         +cOgBYLIhtC1bbL1p8tNr6wk9FUhjvaIwJAefnHg3uI5GHi31PcWCnJHKjjPoVH/oA
         ijkq09PJ7DBWlDbpYMlvb9gqNOG/szr/PW1TycPyM+j+B/Vn2nIWdtlRtIt3OX62nq
         4UfStMXJUYbWSmmi3PADbmR9hP0pSPc64XdWRIB0Q2k4V+64qXjpC4B94di1gh93OK
         +hUgTbdjdTgXqi72nDEMYv5Boku4bqL4EpKsJA4LgVYoy5H9hGyvBZg3bJQRf8rEzu
         d1oE7WpPT4cLw==
Date:   Mon, 27 Nov 2023 11:05:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] bus: imx-weim: Use device_get_match_data()
Message-ID: <20231127030544.GX87953@dragon>
References: <20231025161221.371153-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025161221.371153-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 11:12:21AM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
