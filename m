Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE31758426
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjGRSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjGRSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2591B5;
        Tue, 18 Jul 2023 11:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD73616AC;
        Tue, 18 Jul 2023 18:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE3CC433C7;
        Tue, 18 Jul 2023 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689703615;
        bh=88mOW/Jxt3hWqsKWEzcfOJPc4T/peV4NshcYKjzQeRk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tRIRNV9xuItBjPLIPo5eYoGYUpetQN69SoaS11o/Trrpq+PNH3zu98+n12K66NRXl
         y0Hrs1r5XJkJ0DURie+rFr/KCZKHzCFS2/e5J7JIT5eobHLVBO28Pq6Cc563b66Rfh
         i5nZs4KbH66LYayy6xhq8lLxAalXJ4FpUIzsiKmAARnYdovH0ezvgwaJpwsS4HsgVD
         3HlmmPQR00WxAaXPb3TBvSqfpiQ1irDh9F4spvq8yl7kOmazHllO7Hz5SbH2AYFUIa
         BTJAKgHBoEw1NPOG7Fd5lS7oJHbJaCgegvmC1JJ2/9H4aAXpXCX4eBSnJ98ROAfJ+9
         RRN81ukzNNhrA==
Message-ID: <8331449d-6b25-7ea0-4c28-9128ab483fba@kernel.org>
Date:   Tue, 18 Jul 2023 20:06:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org
References: <20230718155814.1674087-1-kuba@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 17:58, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

