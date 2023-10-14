Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE20F7C95B8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjJNR2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 13:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJNR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 13:28:36 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Oct 2023 10:28:33 PDT
Received: from mail-m6038.netease.com (mail-m6038.netease.com [210.79.60.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0BC9
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 10:28:32 -0700 (PDT)
Received: from [172.23.111.174] (unknown [120.208.100.128])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 68E43800088;
        Sun, 15 Oct 2023 01:19:00 +0800 (CST)
Message-ID: <556752fd-0ae4-45b5-bfb4-5777c8302d48@link.tyut.edu.cn>
Date:   Sun, 15 Oct 2023 01:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/show_delta: add __main__ judgement before main
 code
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     gregkh@linuxfoundation.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, ndesaulniers@google.com,
        n.schier@avm.de, ojeda@kernel.org, linux-kernel@vger.kernel.org
References: <20231013132832.165768-1-2023002089@link.tyut.edu.cn>
 <CANiq72npYE=W6B5Ln42Tr-Z8kPQihQit3k=C_wdO1kcx_Dvpxw@mail.gmail.com>
Content-Language: en-US
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <CANiq72npYE=W6B5Ln42Tr-Z8kPQihQit3k=C_wdO1kcx_Dvpxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQkIaVhkfTRpJSkxDTUgaSVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpJS1VJS0NVSktLVUpJQ1lXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8b2f32cea5b03akuuu68e43800088
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6ITo5Pjw0DA4aVj85Thke
        KjBPCwpVSlVKTUJMSEtIQk9KSUhDVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpJS1VJS0NVSktLVUpJQ1lXWQgBWUFJTUpJNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/14 18:15, Miguel Ojeda wrote:
> On Fri, Oct 13, 2023 at 3:29 PM Hu Haowen <2023002089@link.tyut.edu.cn> wrote:
>> When doing Python programming it is a nice convention to insert the if
>> statement `if __name__ == "__main__":` before any main code that does
>> actual functionalities to ensure the code will be executed only as a
>> script rather than as an imported module. Hence attach the missing
>> judgement to show_delta.
>>
>> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
> I am not sure why I was Cc'd, but the patch looks fine :)


Sorry for troubling you. I have just executed the get_maintainer script
to get the maintainer for the file I'm making the patch toward, with
the result that this file is not maintained by anyone. Consequently I
immediately ran again on the scripts directory, and obtained adequate
information on major commiters of scripts, adding them to the Cc list.

After all, it's nice of you to have ensured the quality of my patch. :)


> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel
>
