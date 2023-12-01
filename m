Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498580088E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378314AbjLAKkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378239AbjLAKkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:40:16 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B6196;
        Fri,  1 Dec 2023 02:40:22 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 1B27220645;
        Fri,  1 Dec 2023 11:40:21 +0100 (CET)
Date:   Fri, 1 Dec 2023 11:40:19 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH v7 11/12] wifi: mwifiex: misc modifications for review
 comments.
Message-ID: <ZWm4E+JjrFFl8U/o@francesco-nb.int.toradex.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-12-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128083115.613235-12-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:31:14PM +0800, David Lin wrote:
> 1. Moved struct mwifiex_ieee80211_mgmt from cfg80211.c to fw.h.
> 2. Defined WLAN_AUTH_NONE instead of using 0xFFFF directly.
> 3. Changed host_mlme of struct mwifiex_adapter to host_mlme_enabled.
> 4. Moved mwifiex_check_key_api_ver() to end of mwifiex_ret_get_hw_spec().
> 5. Redefined MWIFIEX_MGMT_HEADER_LEN and MWIFIEX_AUTH_BODY_LEN.

You should fix the existing patch, not create a fixup commit on top.

Francesco
