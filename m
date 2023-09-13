Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD08579E0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbjIMHTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjIMHTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:19:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE271727;
        Wed, 13 Sep 2023 00:19:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76744C433C8;
        Wed, 13 Sep 2023 07:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694589582;
        bh=cy7DEz0lIpFLZxqiOUHfTDXkS62t4WAJEpcmc0YPNTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMTeWbohEcMDyajrofKRM3dmu12suPlQ8xokQ3LBND+8wL34fdjrPllM/UE9LKZUv
         QfLqFSCUl3VbiYMQdryoZkVDSFlZCIvQOFhPM1N6IJz47LVo9Tg4Hy2FcnZ2VsedjT
         isDgBk3chx3Mo0pjBbQm9uSCYTzJfGJVh4wdDvzo=
Date:   Wed, 13 Sep 2023 09:19:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Add myself
 for RISC-V
Message-ID: <2023091307-narrow-glider-05fa@gregkh>
References: <20230912180657.31841-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912180657.31841-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:06:56AM -0700, Palmer Dabbelt wrote:
> I'm not sure exactly how RISC-V fits into the story here, but I'm happy
> to voluteer a sort of catch-all for vendors who aren't otherwise
> represented.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  Documentation/process/embargoed-hardware-issues.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index cb686238f21d..ac7c52f130c9 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -251,6 +251,7 @@ an involved disclosed party. The current ambassadors list:
>    IBM Z		Christian Borntraeger <borntraeger@de.ibm.com>
>    Intel		Tony Luck <tony.luck@intel.com>
>    Qualcomm	Trilok Soni <tsoni@codeaurora.org>
> +  RISC-V	Palmer Dabbelt <palmer@dabbelt.com>
>    Samsung	Javier González <javier.gonz@samsung.com>
>  
>    Microsoft	James Morris <jamorris@linux.microsoft.com>

Thanks for agreeing to do this, hopefully you'll never have to ever get
notified of anything :)

I'll queue this up in my tree now,

greg k-h
