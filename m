Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370C8008AC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378323AbjLAKnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378331AbjLAKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:43:45 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2546196;
        Fri,  1 Dec 2023 02:43:51 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2054C206C0;
        Fri,  1 Dec 2023 11:43:50 +0100 (CET)
Date:   Fri, 1 Dec 2023 11:43:48 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 12/12] wifi: mwifiex: fixed compile and coding errors.
Message-ID: <ZWm45Kicf5/D64Cm@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-13-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-13-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:31:15PM +0800, David Lin wrote:
> 1. struct cfg80211_rx_assoc_resp -> struct cfg80211_rx_assoc_resp_data.
> 2. Pointer should be used for memcpy.

this is changing code that you just add on this series, no separate
patch.

Francesco

