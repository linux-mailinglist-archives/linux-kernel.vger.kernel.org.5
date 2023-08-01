Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBA76B3F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHALzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHALzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E3173A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:55:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330BB6154A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C2FC433C7;
        Tue,  1 Aug 2023 11:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690890936;
        bh=75N0AL6nh/GGlaa6WPHq86lW5bcuavySMo6LPe1YdjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9BNwV8uaON83bpsaWXkl5J3kleepSr76Zo3nPEpaLvDd5wkwcFl5DyFARH60LZIM
         Gi2yZVJpMOrIwmIr6V9+lN9QJRzvbG3nKD2UUGJG1BUVSxj6cIQOQ1nmOPNPW61HSu
         CW6dj53T2o0TJn3Y3oKwz6jfY2xduGcC/OJ3LU6DXn+irSX/xNqjKopyZAVnm1+Nsq
         apj67YfWyp9XTxjvKAYbRDhucCcTPzLstW5tH0X1q/+LFJrLy4hB8NXjkOJ8DxgHnm
         gNiWz+zuSTK3fGhmBDvu7t04FZGX5ywTW+WClgskfE6NUqMjlnLxtVKQisH2I2EDTL
         6xw8LeeOZG+SQ==
Date:   Tue, 1 Aug 2023 13:55:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, simon.horman@corigine.com,
        jesse.brandeburg@intel.com
Subject: Re: [net-next PATCH V3 0/2] octeontx2-af: TC flower offload changes
Message-ID: <ZMjys4e4/S/dtyj2@kernel.org>
References: <20230801053813.2857958-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801053813.2857958-1-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:08:11AM +0530, Suman Ghosh wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan

Hi Suman,

unfortunately this does not apply to current net-next.
Please considering rebasing and posting as v4.

-- 
pw-bot: changes-requested
