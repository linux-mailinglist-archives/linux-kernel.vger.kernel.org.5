Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE57C7D2F35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbjJWJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjJWJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:56:10 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A6D1BEF;
        Mon, 23 Oct 2023 02:55:18 -0700 (PDT)
X-UUID: 641349a9b8234a0bafd20e544043455d-20231023
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:0f1cefd1-43b8-469e-80dc-403f59fb093e,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-4
X-CID-INFO: VERSION:1.1.32,REQID:0f1cefd1-43b8-469e-80dc-403f59fb093e,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-META: VersionHash:5f78ec9,CLOUDID:76b48594-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:2310231755074GDH39NP,BulkQuantity:0,Recheck:0,SF:64|66|24|17|19|45|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 641349a9b8234a0bafd20e544043455d-20231023
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1671895899; Mon, 23 Oct 2023 17:55:05 +0800
Message-ID: <678a679a-eebf-46e4-b189-cecc7ced2a72@kylinos.cn>
Date:   Mon, 23 Oct 2023 17:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] treewide: Spelling fix in comment
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mokuno@sm.sony.co.jp,
        linville@tuxdriver.com, dcbw@redhat.com, jeff@garzik.org,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kunwu.chan@hotmail.com
References: <20231020093156.538856-1-chentao@kylinos.cn>
 <CAMuHMdUo8tEBQa6soZm=MUWLy2AnkL6Vszt7vzbs-peb20=myQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdUo8tEBQa6soZm=MUWLy2AnkL6Vszt7vzbs-peb20=myQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,
Thank you very much for your advice, I am a rookie, I am not familiar 
with many aspects, and I need to learn more.  I'll modify the patch.

On 2023/10/20 19:07, Geert Uytterhoeven wrote:
> Hi Kunwu,
> 
> Thanks for your patch!
> 
> This is not a treewide change. Hence the oneline-summary should be
> something prefixed by "[net-next] ps3_gelic"
> 
> On Fri, Oct 20, 2023 at 11:32 AM Kunwu Chan <chentao@kylinos.cn> wrote:
>> reques -> request
>>
>> Fixes: 09dde54c6a69 ("PS3: gelic: Add wireless support for PS3")
> 
> No need for a Fixes tag for a spelling fix in a comment.
> 
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
>> --- a/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
>> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_wireless.c
>> @@ -1217,7 +1217,7 @@ static int gelic_wl_set_encodeext(struct net_device *netdev,
>>                  key_index = wl->current_key;
>>
>>          if (!enc->length && (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)) {
>> -               /* reques to change default key index */
>> +               /* request to change default key index */
>>                  pr_debug("%s: request to change default key to %d\n",
>>                           __func__, key_index);
>>                  wl->current_key = key_index;
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
