Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E780FC04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377720AbjLMAK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377727AbjLMAKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:10:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C78DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:10:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247D7C433C9;
        Wed, 13 Dec 2023 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702426231;
        bh=MQxulmHpNRv6UmRfBV673M+2mklcfKpulEm24fODeAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mW95xSkTLWdzImHwfbSbNlwL8EfiL6cKUDEovZjzIZh94Xbugiz926H7cUTZWPTws
         ynuM1cd44ywq76oxQtqdAnenR/765o336QfeldTg16L/cw/ylmNKRrxiMizN9JV1xA
         xLljND/CxoICnuOb3AdQtiOJiLC/zkZEzg6jW8BpYYqEAc6ldr84dqHbu1EQIzWnXa
         WATO1GK4VJXAHdN17wOn0Nwroj60VOr5kcTl+CmXikkxRHjBU+a4yVB2qp+Ry5rz+e
         E5gsT14lUfu8fjU383ip3EY7MDm7c8+u7/1deuVfdAQHH5Q7OfdC7W4e3lUGK8kn6s
         onVotf/BOpUrQ==
Date:   Tue, 12 Dec 2023 16:10:30 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <davem@davemloft.net>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>,
        "Sathesh Edara" <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3] octeon_ep: add PF-VF mailbox communication
Message-ID: <20231212161030.5eb7b84e@kernel.org>
In-Reply-To: <20231211063355.2630028-2-srasheed@marvell.com>
References: <20231211063355.2630028-1-srasheed@marvell.com>
        <20231211063355.2630028-2-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 22:33:52 -0800 Shinas Rasheed wrote:
> Implement mailbox communication between PF and VFs.
> PF-VF mailbox is used for all control commands from VF to PF and
> asynchronous notification messages from PF to VF.

This patch was not designated as 1/4 in the subject so patchwork
thought it's a separate posting, and the series lacks patch 1/4.
You gotta repost so that patchwork can ingest this properly.
-- 
pw-bot: cr
