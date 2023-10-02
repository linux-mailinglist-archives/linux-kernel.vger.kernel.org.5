Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51EE7B5816
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbjJBQ3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjJBQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:29:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5059D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:29:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685D6C433C8;
        Mon,  2 Oct 2023 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696264166;
        bh=QpCSpnoG7LwuCvkuSHevJxs6SD9AbPqTNcEG2W8M/Ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XT+K0p2qqz7a84Jtl/K7iLbYPdyicA/3GSup+Q5pKxuPkGdcyQdZoGHAEKFCP6Ajg
         dU8PMrJYpvNEDOBqmFheh9DOcYoQ9b+RobCG8eHZqk/ie6w6HdezHXhRVMX72SRH/e
         RDeDNwim185wgjl+p9aT56z+OnH2OHDkTQAC7DdMQQpeC1LHeeKbR20o7nSjFvOyC0
         dbTqP6HrMXhN/GxSzugw/KhmLmOhi0b3fOWl92xgcOccKF+usA3inETt6D3V7i4tZf
         eLdL1Wv5Zhx/RSG+FHbVaHvzs7MJJ+HuDxZk8AFHeMut4SkNvjyFPis3ZCbbyVvtIY
         SqWqHqhaI5FFg==
Date:   Mon, 2 Oct 2023 18:29:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     KaiLong Wang <wangkailong@jari.cn>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: snmp: Clean up errors in snmp.h
Message-ID: <20231002162922.GZ92317@kernel.org>
References: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bdec01.8ad.18ad9c80cca.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:14:40AM +0800, KaiLong Wang wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: space required after that ',' (ctx:VxV)
> ERROR: spaces required around that '==' (ctx:VxV)
> 
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

Hi KaiLong Wang,

unfortunately, patches that only contain checkpatch clean-ups
for Networking code are not accepted.

-- 
pw-bot: rejected
