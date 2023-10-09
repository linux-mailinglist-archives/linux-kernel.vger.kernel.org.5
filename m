Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA46F7BD366
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbjJIGdp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJIGdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:33:44 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Oct 2023 23:33:41 PDT
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDC5A3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 23:33:41 -0700 (PDT)
Received: from ip5f5bee74.dynamic.kabel-deutschland.de ([95.91.238.116] helo=redqueen.local)
        by www84.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <stefani@seibold.net>)
        id 1qpjUn-000FgQ-OE; Mon, 09 Oct 2023 08:12:01 +0200
Message-ID: <5fbff954709bbdebe5872dcb40d32aba384cfe43.camel@seibold.net>
Subject: Re: [PATCH v1] samples: kfifo: Fixes a typo
From:   Stefani Seibold <stefani@seibold.net>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Date:   Mon, 09 Oct 2023 08:11:56 +0200
In-Reply-To: <20230817173636.78757-1-atulpant.linux@gmail.com>
References: <20230817173636.78757-1-atulpant.linux@gmail.com>
Autocrypt: addr=stefani@seibold.net; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27055/Sun Oct  8 09:39:49 2023)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked by Stefani Seibold <stefani@seibold.net>

On Thu, 2023-08-17 at 23:06 +0530, Atul Kumar Pant wrote:
> Fixes a typo in a comment.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  samples/kfifo/dma-example.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-
> example.c
> index 0cf27483cb36..112b0e427199 100644
> --- a/samples/kfifo/dma-example.c
> +++ b/samples/kfifo/dma-example.c
> @@ -80,7 +80,7 @@ static int __init example_init(void)
>  			break;
>  	}
>  
> -	/* put here your code to setup and exectute the dma
> operation */
> +	/* put here your code to setup and execute the dma operation
> */
>  	/* ... */
>  
>  	/* example: zero bytes received */
> @@ -109,7 +109,7 @@ static int __init example_init(void)
>  			break;
>  	}
>  
> -	/* put here your code to setup and exectute the dma
> operation */
> +	/* put here your code to setup and execute the dma operation
> */
>  	/* ... */
>  
>  	/* example: 5 bytes transmitted */

