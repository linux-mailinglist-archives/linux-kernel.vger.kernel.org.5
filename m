Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05525763A92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjGZPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjGZPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:12:57 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9743C2F;
        Wed, 26 Jul 2023 08:12:12 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 75E4361E5FE01;
        Wed, 26 Jul 2023 17:11:09 +0200 (CEST)
Message-ID: <2cf9a03e-6d81-64cd-3cc2-0b989e5d5824@molgen.mpg.de>
Date:   Wed, 26 Jul 2023 17:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] Bluetooth: Remove unused declaration
 amp_read_loc_info()
Content-Language: en-US
To:     yuehaibing@huawei.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726142817.20504-1-yuehaibing@huawei.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230726142817.20504-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear YueHaibing,


Thank you very much for your patch.

Am 26.07.23 um 16:28 schrieb YueHaibing:
> This is never used, so remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Should your name be spelled with a space: Yue Haibing?

     $ git config --global user.name "Yue Haibing"
     $ git commit --amend --author="Yue Haibing <yuehaibing@huawei.com>"

> ---
>   net/bluetooth/amp.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
> index 832764dfbfb3..97c87abd129f 100644
> --- a/net/bluetooth/amp.h
> +++ b/net/bluetooth/amp.h
> @@ -28,7 +28,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
>   
>   int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
>   
> -void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);

Was it never implemented, or just forgotten to be removed?

>   void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
>   void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
>   void amp_read_loc_assoc_final_data(struct hci_dev *hdev,


Kind regards,

Paul
