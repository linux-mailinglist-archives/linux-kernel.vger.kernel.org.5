Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B304C7ECA12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjKOR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjKOR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:56:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266E91A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:56:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC74C433C7;
        Wed, 15 Nov 2023 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700070990;
        bh=seHXsU+nC1ZI4hISDFAU4lqI5nICNlP3RwnhFpogd+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcR27uIgLKUK330DPYPiyQ0eWauPjEUx9x8R5nO3xTTjJalEFtrdPIXhkcHN645hs
         1PxN/V0jRlrYNj8VGtcd2mj6vx40Mthwe/6Mj6CX0mw7mGPF04KVZhm5bhiFIN55sV
         LkwWOeWYkFi/vKpoYei0sAxNbCXO5kynFQoWPlHY5gX4H7wiHZlSaVn7ImLtAWLXjN
         9XD6VeH8UY4ahJV0mNVRgGF7kFh4ya+8jP1Gx7FQT964HiBXZMZXZyvyZNsxjE5Q9Z
         nGHsrSWkuqsRcrrLQlyJMjTMkhBfbATRBURLIXhGqx2dWbojOKuJLe/CHFieUiP2hw
         FbdsZnRXT9CAg==
Date:   Wed, 15 Nov 2023 17:56:26 +0000
From:   Simon Horman <horms@kernel.org>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] indirect_call_wrapper: Fix typo in
 INDIRECT_CALL_$NR kerneldoc
Message-ID: <20231115175626.GW74656@kernel.org>
References: <20231114104202.4680-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114104202.4680-1-tklauser@distanz.ch>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jakub, Dave and Eric

On Tue, Nov 14, 2023 at 11:42:02AM +0100, Tobias Klauser wrote:
> Fix a small typo in the kerneldoc comment of the INDIRECT_CALL_$NR
> macro.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks Tobias,

I agree this is correct.

Reviewed-by: Simon Horman <horms@kernel.org>


To the netdev maintainers: get_maintainer.pl doesn't seem to
know much about include/linux/indirect_call_wrapper.h.
Should that be fixed?
