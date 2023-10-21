Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8819F7D19C8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 02:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjJUADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 20:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJUADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 20:03:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E6D67
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 17:03:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701EBC433C7;
        Sat, 21 Oct 2023 00:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697846594;
        bh=yx4b5fn0c6i/eWSkHChzUW6XYw4N9dR7DJEx3AAQzKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HO41pWF4QiVeyQdPM9A8bwglMTkInB+dDxLsibIcJ30M+4iCc9NpMlN4JttCNzuaK
         I0X1YuLX1KLGw99923ETQopyWBDfkGs4geJUBuctgKXlTwLzelPSiWGMIY15iU+aUd
         yMyu6R5D0p1G+noEVVZD3ia8XWI492fPN30rc3YTrazlWaBy7gEQ5KO63eh+IeqSwe
         qaP4ucYpaw5nJPDqHHyzsvTdPJVSCwle669n/x7ACYuxC6EW/+MDpB2nOkRb/Djs+s
         ykmMHQc+LybdfhMTFle5SpngmM//y3uCXr572zhDZa/75v1wJ0nr/q9GuZfKwG9HPT
         qg3j2dn2Cs76A==
Date:   Fri, 20 Oct 2023 17:03:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mokuno@sm.sony.co.jp, linville@tuxdriver.com, dcbw@redhat.com,
        jeff@garzik.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kunwu.chan@hotmail.com
Subject: Re: [PATCH] treewide: Spelling fix in comment
Message-ID: <20231020170312.5baf8c59@kernel.org>
In-Reply-To: <20231020093156.538856-1-chentao@kylinos.cn>
References: <20231020093156.538856-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 17:31:56 +0800 Kunwu Chan wrote:
> reques -> request
> 
> Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Appears to have been applied to net, thank you!
