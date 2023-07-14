Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6C753AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjGNMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjGNMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:21:19 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5831FD6;
        Fri, 14 Jul 2023 05:21:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6D8535BC3A;
        Fri, 14 Jul 2023 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689337277;
        bh=d4xdbM7mD74srDSAziRnx5VmguuxEc0Aefz9EyiBpKg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=z0Tg6hChx+665MPA0IvfNrMkvYn9RjQVZcSbfpBXdUr4QUBI0tLrIYxPIJlsp5olS
         q3Xlx77MQrjLvv75QzlJmylZVXKZ/qus2XEkoI9K2jms7ldL60uDD0RorSeGpStrx4
         iNBCY1EqVsxshjaBEwn/YLvZCSZZyxlUWgPeqav9eEdiKFeWp1o3DTycDVV/sIpMEa
         adrNj5Bo6AOC9vmaCn3rhRXE+2Ms16oaHzWra+ATekIDLEGjuMQsjlFSUSnu9aeIz0
         IIRmt22tLKX44ZQv8KUu14Rkl50YC5OQtscGmYosNYg35i3MH9tuZ26SFlB80DLJZr
         rH3Ge0WAmq5pg==
Message-ID: <15a21f18-485d-37d8-0a5e-417702787204@asahilina.net>
Date:   Fri, 14 Jul 2023 21:21:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
 <20230714094844.2189906-1-aliceryhl@google.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230714094844.2189906-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 18.48, Alice Ryhl wrote:
> Asahi Lina <lina@asahilina.net> writes:
>> Trivial implementation.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
> 
> The commit message is a bit short, but the change itself looks fine.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

It's so trivial I just didn't know what else to write... suggestions 
welcome (for this or next time I have a patch like this) ^^

~~ Lina

