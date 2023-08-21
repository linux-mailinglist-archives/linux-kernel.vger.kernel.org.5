Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F5782D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjHUPPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHUPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:15:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CBDBC;
        Mon, 21 Aug 2023 08:15:04 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B121766071A2;
        Mon, 21 Aug 2023 16:15:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692630903;
        bh=yOP/crzuh324Aakcxxz+eZDVYJZgYrNZoRWG4V5bccQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kxw8+vzPsdiXctTFi0QYl6nsI1jma5ed2T2gzHXgiSoGxahsSOn09uc1WKF59ENtg
         pdDyTrzmhDgvkXXCErA+3Jwn86Nex+xNS2n4BjX1ONWyIAm5q4DobU9ZkAuIiy2OCi
         YmfV6/xD1mNcumpRFapH8wU06O/3Unz9CasZn25bJXTPMPm3oCVYQVY5mKLP3M62db
         yqY0IWo90gmqNqgTlnS4smnKs3B2V2FPWLDYuSSMBmW9CYztsxwzIIdhxyS2y5GLk/
         mX5E0l25cKdFYtBux03+ubQztI3f89DPz/GLZ8GIXTIAyVMgWQuW8uJjKNFF12Sz4I
         Za9Zqx9pyTPNg==
Message-ID: <f21dfae7466a441fbe175db62ad3c9aa4eff3f0c.camel@collabora.com>
Subject: Re: [PATCH][next] media: mediatek: vcodec: fix spelling mistake
 "resonable" -> "reasonable"
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 21 Aug 2023 11:14:52 -0400
In-Reply-To: <20230815121446.742742-1-colin.i.king@gmail.com>
References: <20230815121446.742742-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 15 ao=C3=BBt 2023 =C3=A0 13:14 +0100, Colin Ian King a =C3=A9crit=
=C2=A0:
> There are a couple of spelling mistakes in pr_err error messages. Fix the=
m.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c   | 2 +-
>  .../media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
scp.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
> index 9e744d07a1e8..6bbe55de6ce9 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
> @@ -68,7 +68,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(void *priv=
, enum mtk_vcodec_fw_use
> =20
>  		plat_dev =3D dec_dev->plat_dev;
>  	} else {
> -		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
> +		pr_err("Invalid fw_use %d (use a reasonable fw id here)\n", fw_use);
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_=
vpu.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> index 5e03b0886559..9f6e4b59455d 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c
> @@ -109,7 +109,7 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_vpu_init(void *pr=
iv, enum mtk_vcodec_fw_use
>  		plat_dev =3D dec_dev->plat_dev;
>  		rst_id =3D VPU_RST_DEC;
>  	} else {
> -		pr_err("Invalid fw_use %d (use a resonable fw id here)\n", fw_use);
> +		pr_err("Invalid fw_use %d (use a reasonable fw id here)\n", fw_use);
>  		return ERR_PTR(-EINVAL);
>  	}
> =20

