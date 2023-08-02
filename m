Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2576D6F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHBSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHBSjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:39:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92F41FFF;
        Wed,  2 Aug 2023 11:39:03 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qRGkD-0003CV-8a; Wed, 02 Aug 2023 20:38:49 +0200
Date:   Wed, 2 Aug 2023 20:38:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Abel Vesa <abelvesa@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ARM: imx25: print silicon revision at startup
Message-ID: <20230802183849.2gzlglkskvzkgiwa@viti.kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
 <20230730163928.70637-1-martin@kaiser.cx>
 <e0acf791831bcfed56d56c97f6867a89.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0acf791831bcfed56d56c97f6867a89.sboyd@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd (sboyd@kernel.org) wrote:

> You need to Cc linux-imx@nxp.com on imx clk patches. I think Abel has
> some filter that looks for linux-clk@vger and linux-imx.

> Also, please don't send series replies to previous rounds. It buries the
> patches deep in my MUA and my scripts don't work well to apply patches
> when they're sent like that.

> I presume that Abel will pick the patches up? Or do you want to land
> them through Arnd's tree? Either way feel free to add my acked-by

> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks for responding, Stephen.

Ok, understood. I'll resend with Cc linux-imx@nxp.com and without the
reply to previous versions.

Arnd, are you ok with taking these patches through your tree as
suggested by Stephen?

Thanks,
Martin
