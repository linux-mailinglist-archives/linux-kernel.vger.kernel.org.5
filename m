Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC88A78813A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241628AbjHYHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbjHYHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472F1FD9;
        Fri, 25 Aug 2023 00:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3C064C2C;
        Fri, 25 Aug 2023 07:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A03C433C7;
        Fri, 25 Aug 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692949690;
        bh=8KBY+xkGvs+tWbhG1+DEDUTktwV/kRaCdyImzo401Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgQ0UuHfPuRZ2Kzkboe38fZNoYRF7+ZRGBa1kfQO0C7Nisx4td34BH1D8iafciMGN
         MZC5N0SO8dWeIW/VG9x5D2t6EHxerKkjqaezxx7STXbo/1Uqp2YDq7QnhS+ahiL6hN
         gUuec67GQAZZggxfpOC9jcms13xu6irn7WZfjk2LRwRXT90uBh6SoxN9i9wuwTRzIn
         zQSd4cuOiOcdONbDhPALWKEJ8fHunLFYQdPPmjsPmmOk2BlkP1dpKw/DU40QmCTpMQ
         X/psgf5LxQMeSsqBoGCGisM2SYrr5VsWTuq+GWzQtbIBXnijuHnHe+e4Gu/UxD/P6k
         WxLxGDWE0PNTw==
Date:   Fri, 25 Aug 2023 09:48:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork: Fix kernel-doc
Message-ID: <20230825-einhorn-deplatziert-5414bacd3cd0@brauner>
References: <20230824193644.3029141-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824193644.3029141-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:36:44PM +0100, Matthew Wilcox wrote:
> Fix the various warnings from kernel-doc in kernel/fork.c
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
