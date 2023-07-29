Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28792767EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjG2LX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2LX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F53107
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 740E760BC0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ADDC433C8;
        Sat, 29 Jul 2023 11:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690629805;
        bh=CPTJ5Z6WlgW7UB/hlIq12BfQzW1KcHNN+l8dUL6xhNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efKJGx/rnSXr3xerEH42OfktHJyWwDhArspS+XP4lvt0nB5a2wM2+hnYoAIShLJ8V
         44PR1dwSO5XkBo55po1vO6BA1G3PQdw82Sq9CzUJkd5M2asySWO/Uqpwh9ewuGsWMg
         XPuET9u4hs6wmf/Me5J9XjkWdupvbWSAxJRyO0QgdLBQNbdb96miiXiCXLgjrbuO7w
         efE4dFbJ4TfFYiVr90Jbx/jXpGIRd4YzUSJpBpAYQuzY79gy+OH4PAW+b5cuLQCkAo
         uDMe0YdozNBbScWp50u6l1WGRu5IkbjZyqLtyiSHB9D/4QzQQCFjnmPpDMkswIpbhf
         gR5LeyAPdDP+Q==
Date:   Sat, 29 Jul 2023 13:23:22 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Remove unused extern declaration
 devlink_port_region_destroy()
Message-ID: <ZMT2qukr6KbfZvKT@kernel.org>
References: <20230728132113.32888-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728132113.32888-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:21:13PM +0800, Yue Haibing wrote:
> devlink_port_region_destroy() is never implemented since
> commit 544e7c33ec2f ("net: devlink: Add support for port regions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>
