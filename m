Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113C7727FF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjHGOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjHGOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:39:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7010E3;
        Mon,  7 Aug 2023 07:38:58 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qT1Nf-0001nW-DE; Mon, 07 Aug 2023 16:38:47 +0200
Date:   Mon, 7 Aug 2023 16:38:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ARM: imx25: print silicon revision at startup
Message-ID: <20230807143847.wcqsmgyqvo3qhfxm@viti.kaiser.cx>
References: <20220602080344.208702-1-martin@kaiser.cx>
 <20230730163928.70637-1-martin@kaiser.cx>
 <e0acf791831bcfed56d56c97f6867a89.sboyd@kernel.org>
 <20230802183849.2gzlglkskvzkgiwa@viti.kaiser.cx>
 <20230806032353.GX151430@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806032353.GX151430@dragon>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Guo (shawnguo@kernel.org) wrote:

> I prefer to have Abel apply the patches through clk tree rather than
> arm-soc tree, unless there is a good reason for them to go via the
> latter.

ok with me. I'd be happy to get this sorted (one way or another) so that
Arnd can enable -Werror=missing-prototypes for 6.6.

Abel, could you pick up these patches?

Thanks,
Martin
